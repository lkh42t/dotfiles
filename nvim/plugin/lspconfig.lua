local lspconfig = require("lspconfig")

-- on_attach {{{
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

local function on_attach(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format, bufopts)
  vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<Leader>td", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<Leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
end

local function disable_formatter(client, _)
  client.server_capabilities.documentFormattingProvider = false
end
-- }}}

-- create new capabilities to enable snippets {{{
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- }}}

-- language servers {{{
local servers = {
  bashls = {},
  clangd = {},
  cssls = {
    cmd = { "vscode-css-languageserver", "--stdio" },
    on_attach = disable_formatter,
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
      "javascript",
      "javascriptreact",
      "lua",
      "rst",
      "sh",
      "typescript",
      "typescriptreact",
      "yaml",
      "zsh",
    },
    init_options = { documentFormatting = true },
  },
  emmet_ls = {
    filetypes = { "css", "html", "htmldjango", "javascriptreact", "scss", "typescriptreact" },
  },
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
      },
    },
    init_options = {
      usePlaceholders = true,
    },
  },
  html = {
    cmd = { "vscode-html-languageserver", "--stdio" },
    filetypes = { "html", "htmldjango" },
    on_attach = disable_formatter,
  },
  jsonls = {
    cmd = { "vscode-json-languageserver", "--stdio" },
  },
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          flake8 = { enabled = true },
          mccabe = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
        },
      },
    },
  },
  rust_analyzer = {},
  sqls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = (function()
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            return runtime_path
          end)(),
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      },
    },
    on_attach = disable_formatter,
  },
  texlab = {
    settings = {
      texlab = {
        chktex = { onOpenAndSave = true },
      },
    },
  },
  tsserver = {
    on_attach = disable_formatter,
  },
  vimls = {},
  yamlls = {},
}

for server, config in pairs(servers) do
  if type(config) == "function" then
    config = config()
  end

  if config.on_attach ~= nil then
    local _on_attach = config.on_attach
    config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      _on_attach(client, bufnr)
    end
  else
    config.on_attach = on_attach
  end

  config.capabilities = capabilities
  lspconfig[server].setup(config)
end
-- }}}
