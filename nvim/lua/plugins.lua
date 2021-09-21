local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- editor scheme
  use("fneu/breezy")
  use("itchyny/lightline.vim")

  -- language support
  use({ "dart-lang/dart-vim-plugin", ft = "dart" })

  -- editor enhancement
  use("editorconfig/editorconfig-vim")
  use("airblade/vim-gitgutter")
  use("tpope/vim-fugitive")
  use("tpope/vim-surround")
  use("tpope/vim-commentary")
  use("cohama/lexima.vim")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("ctrlpvim/ctrlp.vim")

  -- language server and completion
  use("neovim/nvim-lspconfig")
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
    },
  })
end)

if vim.fn.empty(vim.fn.glob(vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua")) > 0 then
  vim.cmd([[PackerCompile]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
