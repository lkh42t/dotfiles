--- @type vim.lsp.Config
return {
  filetypes = { "bash", "sh", "zsh" },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
