--- @type vim.lsp.Config
return {
  init_options = {
    vimruntime = vim.env.VIMRUNTIME,
    runtimepath = vim.o.runtimepath,
  },
}
