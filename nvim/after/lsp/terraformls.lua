--- @type vim.lsp.Config
return {
  init_options = {
    terraform = {
      path = vim.fn.exepath("tofu"),
    },
  },
}
