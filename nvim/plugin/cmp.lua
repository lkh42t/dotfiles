local function feedkeys(s)
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(s, true, true, true), "i")
end

local cmp = require("cmp")
cmp.setup({
  sources = {
    {
      name = "buffer",
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
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
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#jumpable"](1) > 0 then
        feedkeys("<Plug>(vsnip-jump-next)")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) > 0 then
        feedkeys("<Plug>(vsnip-jump-prev)")
      else
        fallback()
      end
    end,
  },
})
