local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- {{{ language servers without specific settings
local servers = {
  "bashls",
  "clangd",
  "cmake",
  "dartls",
  "gopls",
  "jedi_language_server",
  "rust_analyzer",
  "texlab",
}
for _, server in ipairs(servers) do
  lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
end
-- }}}

-- {{{ diagnostic-languageserver
lspconfig.diagnosticls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "lua", "python", "sh", "zsh" },
  init_options = {
    -- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
    linters = {
      flake8 = {
        command = "flake8",
        debounce = 100,
        args = { "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s", "-" },
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = "flake8",
        formatLines = 1,
        formatPattern = {
          [[(\d+),(\d+),([A-Z]),(.*)(\r|\n)*$]],
          { line = 1, column = 2, security = 3, message = 4 },
        },
        security = { W = "warning", E = "error", F = "error", C = "error", N = "error" },
      },
    },
    filetypes = {
      python = "flake8",
    },
    -- https://github.com/iamcco/diagnostic-languageserver/wiki/Formatters
    formatters = {
      black = {
        command = "black",
        args = { "-q", "-" },
      },
      isort = {
        command = "isort",
        args = { "-q", "-" },
      },
      shfmt = {
        command = "shfmt",
      },
      stylua = {
        command = "stylua",
        args = { "-s", "-" },
      },
    },
    formatFiletypes = {
      lua = "stylua",
      python = { "isort", "black" },
      sh = "shfmt",
      zsh = "shfmt",
    },
  },
})
-- }}}

-- {{{ Lua language server
local system_name
if vim.fn.has("mac") > 0 then
  system_name = "macOS"
elseif vim.fn.has("unix") > 0 then
  system_name = "Linux"
else
  system_name = "Windows"
end

local sumneko_root = vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server"
local sumneko_bin = sumneko_root .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { sumneko_bin, "-E", sumneko_root .. "/main.lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = runtime_path },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
})
-- }}}
