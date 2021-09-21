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
  buf_set_keymap("v", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
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
  cmake = {},
  dartls = {},
  diagnosticls = {
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
          securities = { W = "warning", E = "error", F = "error", C = "error", N = "error" },
        },
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
        python = "flake8",
        sh = "shellcheck",
        zsh = "shellcheck",
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
  },
  gopls = {},
  jedi_language_server = {},
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
