-- UI customization {{{
vim.o.winborder = "single"
-- }}}

-- Global keymaps {{{
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)
-- }}}

-- on_attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    require("lsp_signature").on_attach({ zindex = 50 }, ev.buf)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.treesitter.query.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<Leader>td", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<Leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  end,
})
-- }}}

-- language servers {{{
local servers = {
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "dartls",
  "dockerls",
  "efm",
  "esbonio",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruff",
  "rust_analyzer",
  "terraformls",
  "texlab",
  "ts_ls",
  "vimls",
  "yamlls",
}
local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in ipairs(servers) do
  vim.lsp.config(server, { capability = default_capabilities })
end
vim.lsp.enable(servers)
-- }}}
