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
        diagnosticMode = "off",
        diagnosticSeverityOverrides = {
          reportInvalidTypeForm = "none",
          reportMissingImports = "none",
          reportMissingModuleSource = "none",
          reportUndefinedVariable = "none",
        },
        typeCheckingMode = "off",
      },
    },
  },
}
