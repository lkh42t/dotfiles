local lspconfig = require("lspconfig")

-- UI customization {{{
local border = {
  { "┌", "FloatBorder" },
  { "─", "FloatBorder" },
  { "┐", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┘", "FloatBorder" },
  { "─", "FloatBorder" },
  { "└", "FloatBorder" },
  { "│", "FloatBorder" },
}

local util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return util_open_floating_preview(contents, syntax, opts, ...)
end
-- }}}

-- on_attach {{{
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    require("lsp_signature").on_attach({}, ev.buf)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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

-- create new capabilities to enable snippets {{{
local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
      "sh",
      "typescript",
      "typescriptreact",
      "yaml",
      "zsh",
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
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          },
        })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
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
  terraformls = {},
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

  if config.capabilities ~= nil then
    config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities)
  else
    config.capabilities = capabilities
  end

  lspconfig[server].setup(config)
end
-- }}}
