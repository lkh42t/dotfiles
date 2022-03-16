local lspconfig = require("lspconfig")

-- customize diagnostics {{{
vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = false,
})
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
-- }}}

-- on_attach {{{
local function on_attach(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<Leader>gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<Leader>gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>td", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<Leader>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>e", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
end

local function disable_formatter(client, _)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
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
  },
  cmake = {},
  dartls = {},
  dockerls = {},
  efm = {
    filetypes = { "lua", "rst", "sh", "zsh" },
    init_options = { documentFormatting = true },
  },
  emmet_ls = {},
  gopls = {},
  html = {
    cmd = { "vscode-html-languageserver", "--stdio" },
    filetypes = { "html", "htmldjango" },
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
        telemetry = {
          enable = false,
        },
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
  tsserver = {},
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
  config.flags = { debounce_text_changes = 100 }
  lspconfig[server].setup(config)
end
-- }}}
