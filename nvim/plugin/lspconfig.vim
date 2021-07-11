lua <<EOF
local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {'documentation', 'detail', 'additionalTextEdits'},
}

local servers = {
  'bashls',
  'clangd',
  'cmake',
  'dartls',
  'gopls',
  'jedi_language_server',
  'texlab',
  'rust_analyzer',
}
for _, server in ipairs(servers) do
  lspconfig[server].setup{on_attach = on_attach, capabilities = capabilities}
end

lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'python', 'sh', 'zsh'},
  init_options = {
    -- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
    linters = {
      flake8 = {
        command = 'flake8',
        debounce = 100,
        args = {'--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s', '-'},
        offsetLine = 0, offsetColumn = 0,
        sourceName = 'flake8',
        formatLines = 1,
        formatPattern = {
          [[(\d+),(\d+),([A-Z]),(.*)(\r|\n)*$]],
          {line = 1, column = 2, security = 3, message = 4},
        },
        security = {W = 'warning', E = 'error', F = 'error', C = 'error', N = 'error'},
      },
    },
    filetypes = {
      python = {'flake8'}
    },
    -- https://github.com/iamcco/diagnostic-languageserver/wiki/Formatters
    formatters = {
      black = {
        command = 'black',
        args = {'--quiet', '-'},
      },
      isort = {
        command = 'isort',
        args = {'--quiet', '-'},
      },
      shfmt = {
        command = 'shfmt',
      },
    },
    formatFiletypes = {
      python = {'isort', 'black'},
      sh = 'shfmt',
      zsh = 'shfmt'
    },
  },
}
EOF
