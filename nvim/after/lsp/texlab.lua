--- @type vim.lsp.Config
return {
  settings = {
    texlab = {
      build = {
        executable = "llmk",
        args = {},
      },
      chktex = { onOpenAndSave = true },
    },
  },
}
