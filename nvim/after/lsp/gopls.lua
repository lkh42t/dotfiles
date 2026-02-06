--- @type vim.lsp.Config
return {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
}
