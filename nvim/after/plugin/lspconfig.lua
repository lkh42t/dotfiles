-- UI customization {{{
vim.o.winborder = "single"
-- }}}

-- Global keymaps {{{
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  elseif vim.snippet.active({ direction = -1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })
-- }}}

-- on_attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    require("lsp_signature").on_attach({}, ev.buf)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.treesitter.query.omnifunc"
    if client:supports_method("textDocument/completion") then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })
    end

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<Leader>td", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<Leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  end,
})

local function build_on_attach_callback(callbacks)
  return function(client, bufnr)
    if type(callbacks) == "function" then
      callbacks(client, bufnr)
    elseif type(callbacks) == "table" then
      for _, cb in ipairs(callbacks) do
        cb(client, bufnr)
      end
    end
  end
end

local function disable_formatter(client, _)
  client.server_capabilities.documentFormattingProvider = false
end

local function disable_hover(client, _)
  client.server_capabilities.hoverProvider = false
end
-- }}}

-- language servers {{{
local servers = {
  bashls = {},
  clangd = {},
  cssls = {
    init_options = {
      provideFormatter = false,
    },
  },
  cmake = {},
  dartls = {
    settings = {
      dart = {
        completeFunctionCalls = true,
        enableSnippets = true,
      },
    },
  },
  dockerls = {},
  efm = {
    filetypes = {
      "css",
      "dockerfile",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "lua",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
    init_options = { documentFormatting = true },
  },
  esbonio = {},
  eslint = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
      },
    },
  },
  html = {
    filetypes = { "html", "htmldjango" },
    init_options = {
      provideFormatter = false,
    },
  },
  jsonls = {
    init_options = {
      provideFormatter = false,
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        format = {
          enable = false,
        },
      },
    },
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          library = { vim.env.VIMRUNTIME },
          -- library = vim.api.nvim_get_runtime_file("", true),
        },
      })
    end,
  },
  pyright = {
    capabilities = {
      textDocument = {
        publishDiagnostics = {
          tagSupport = {
            valueSet = { 2 },
          },
        },
      },
    },
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          diagnosticMode = "off",
          diagnosticSeverityOverrides = {
            reportInvalidTypeForm = "none",
            reportMissingImports = "none",
            reportMissingModuleSource = "none",
            reportUndefinedVariable = "none",
          },
          typeCheckingMode = "off",
        },
      },
    },
  },
  ruff = {
    on_attach = disable_hover,
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  terraformls = {
    init_options = {
      terraform = {
        path = vim.fn.exepath("tofu"),
      },
    },
  },
  texlab = {
    settings = {
      texlab = {
        build = {
          executable = "llmk",
          args = {},
        },
        chktex = { onOpenAndSave = true },
      },
    },
  },
  ts_ls = {
    on_attach = disable_formatter,
  },
  vimls = {
    init_options = {
      vimruntime = vim.env.VIMRUNTIME,
      runtimepath = vim.o.runtimepath,
    },
  },
  yamlls = {},
}

for server, config in pairs(servers) do
  if type(config) == "function" then
    config = config()
  end

  if config.on_attach ~= nil then
    config.on_attach = build_on_attach_callback(config.on_attach)
  end

  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
-- }}}
