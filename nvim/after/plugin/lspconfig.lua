-- UI customization {{{
vim.o.winborder = "single"
-- }}}

-- Global keymaps {{{
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  elseif vim.snippet.active({ direction = -1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })
-- }}}

-- on_attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    require("lsp_signature").on_attach({ zindex = 50 }, ev.buf)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.treesitter.query.omnifunc"
    if client:supports_method("textDocument/completion") then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })
    end

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
vim.lsp.enable(servers)
-- }}}
