local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

require'packer'.startup(function()
  use 'wbthomason/packer.nvim'

  -- editor scheme
  use 'fneu/breezy'
  use 'itchyny/lightline.vim'

  -- language support
  use 'JuliaEditorSupport/julia-vim'
  use 'dart-lang/dart-vim-plugin'

  -- editor enhancement
  use 'editorconfig/editorconfig-vim'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use 'preservim/nerdcommenter'
  use 'cohama/lexima.vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'ctrlpvim/ctrlp.vim'

  -- language server and completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/nvim-vsnip'
  use 'hrsh7th/nvim-vsnip-integ'
end)

if fn.empty(fn.glob(fn.stdpath('config') .. '/plugin/packer_compiled.lua')) then
  vim.cmd[[PackerCompile]]
end

vim.cmd[[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]
