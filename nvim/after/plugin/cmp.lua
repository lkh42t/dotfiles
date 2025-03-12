local function feedkeys(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local nvim010 = vim.fn.has("nvim-0.10")

local snippet = {
  expand = nvim010 and function(body)
    vim.snippet.expand(body)
  end or function(body)
    vim.fn["vsnip#anonymous"](body)
  end,
  next_available = nvim010 and function()
    return vim.snippet.active({ direction = 1 })
  end or function()
    return vim.fn["vsnip#available"](1) > 0
  end,
  prev_available = nvim010 and function()
    return vim.snippet.active({ direction = -1 })
  end or function()
    return vim.fn["vsnip#jumpable"](-1) > 0
  end,
  jump_next = nvim010 and function()
    vim.snippet.jump(1)
  end or function()
    feedkeys("<Plug>(vsnip-expand-or-jump)", "")
  end,
  jump_prev = nvim010 and function()
    vim.snippet.jump(-1)
  end or function()
    feedkeys("<Plug>(vsnip-jump-prev)", "")
  end,
}

local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "vsnip" },
  }),
  snippet = {
    expand = function(args)
      snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippet.next_available() then
        snippet.jump_next()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippet.prev_available() then
        snippet.jump_prev()
      end
    end, { "i", "s" }),
  }),
})
