local lspconfig = require("lspconfig")

-- {{{ on_attach
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
  buf_set_keymap("n", "<Leader>gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<Leader>gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>td", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
end
-- }}}

-- {{{ create new capabilities to enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- }}}

-- {{{ language servers
local servers = {
  bashls = {},
  clangd = {
    cmd = {
      "clangd",
      "--all-scopes-completion",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--cross-file-rename",
      "--header-insertion=iwyu",
    },
  },
  cssls = {
    cmd = { "vscode-css-languageserver", "--stdio" },
  },
  cmake = {},
  dartls = {},
  diagnosticls = {
    filetypes = { "lua", "sh", "zsh" },
    init_options = {
      -- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
      linters = {
        shellcheck = {
          command = "shellcheck",
          debounce = 100,
          args = { "-f", "json", "-s", "bash", "-" },
          sourceName = "shellcheck",
          parseJson = {
            line = "line",
            command = "command",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${code}]",
            security = "level",
          },
          securities = { error = "error", warning = "warning", info = "info", style = "hint" },
        },
      },
      filetypes = {
        sh = "shellcheck",
        zsh = "shellcheck",
      },
      -- https://github.com/iamcco/diagnostic-languageserver/wiki/Formatters
      formatters = {
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
        sh = "shfmt",
        zsh = "shfmt",
      },
    },
  },
  gopls = {},
  html = {
    cmd = { "vscode-html-languageserver", "--stdio" },
    filetypes = { "html", "htmldjango" },
  },
  jsonls = {
    cmd = { "vscode-json-languageserver", "--stdio" },
  },
  pylsp = {},
  rust_analyzer = {},
  sumneko_lua = function()
    local cmd
    if vim.fn.executable("lua-language-server") > 0 then
      cmd = { "lua-language-server" }
    else
      local system_name
      if vim.fn.has("mac") > 0 then
        system_name = "macOS"
      elseif vim.fn.has("unix") > 0 then
        system_name = "Linux"
      elseif vim.fn.has("win32") > 0 then
        system_name = "Windows"
      else
        print("Unsupported system")
        return {}
      end

      local sumneko_root = vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server"
      local sumneko_bin = sumneko_root .. "/bin/" .. system_name .. "/lua-language-server"

      cmd = { sumneko_bin, "-E", sumneko_root .. "/main.lua" }
    end

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    return {
      cmd = cmd,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT", path = runtime_path },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
      },
    }
  end,
  texlab = {
    settings = {
      texlab = {
        chktex = { onOpenAndSave = true },
      },
    },
  },
  tsserver = {},
  vimls = {},
}

for server, config in pairs(servers) do
  if type(config) == "function" then
    config = config()
  end
  config.on_attach = on_attach
  config.capabilities = capabilities
  config.flags = { debounce_text_changes = 100 }
  lspconfig[server].setup(config)
end
-- }}}
