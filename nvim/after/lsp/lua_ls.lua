--- @type vim.lsp.Config
return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
