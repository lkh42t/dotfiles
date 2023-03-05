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
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

local function on_attach(_, bufnr)
  require("lsp_signature").on_attach({}, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
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

local function disable_formatter(client, bufnr)
  on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
end
-- }}}

-- create new capabilities to enable snippets {{{
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- }}}

-- language servers {{{
local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
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
      "sh",
      "typescript",
      "typescriptreact",
      "yaml",
      "zsh",
    },
    init_options = { documentFormatting = true },
  },
  emmet_ls = {
    filetypes = { "css", "html", "htmldjango", "scss" },
  },
  esbonio = {},
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
    on_attach = disable_formatter,
  },
  jsonls = {},
  lua_ls = {
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
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
    on_attach = disable_formatter,
  },
  pylsp = {
    settings = {
      pylsp = {
        configurationSources = { "flake8" },
        plugins = {
          flake8 = { enabled = true },
          jedi_completion = {
            cache_for = { "aws_cdk", "matplotlib", "numpy", "pandas" },
          },
          mccabe = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
        },
      },
    },
  },
  rust_analyzer = {},
  sqls = {},
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
  tsserver = {
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

  if config.on_attach == nil then
    config.on_attach = on_attach
  end

  config.capabilities = capabilities
  lspconfig[server].setup(config)
end
-- }}}
