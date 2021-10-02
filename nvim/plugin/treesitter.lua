require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
})
require("nvim-treesitter.install").prefer_git = true
