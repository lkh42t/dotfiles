local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "buffer" },
    { name = "calc" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-n>"), "n")
      elseif vim.fn["vsnip#jumpable"]({ 1 }) == 1 then
        vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), "")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-p>"), "n")
      elseif vim.fn["vsnip#jumpable"]({ -1 }) == 1 then
        vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), "")
      else
        fallback()
      end
    end,
  },
})
