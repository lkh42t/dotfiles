local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) then
  vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- editor scheme
  use("fneu/breezy")
  use("itchyny/lightline.vim")

  -- language support
  use("JuliaEditorSupport/julia-vim")
  use("dart-lang/dart-vim-plugin")

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
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-calc")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/vim-vsnip-integ")
end)

if vim.fn.empty(vim.fn.glob(vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua")) then
  vim.cmd([[PackerCompile]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
