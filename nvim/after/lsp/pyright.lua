--- @type vim.lsp.Config
return {
  capabilities = {
    textDocument = {
      publishDiagnostics = {
        tagSupport = {
          valueSet = { 2 },
        },
      },
    },
  },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}
