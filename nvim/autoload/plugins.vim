function! plugins#setup() abort
  let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs ' . url
  endif

  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \ | PlugInstall --sync | source $MYVIMRC
  \ | endif

  call plug#begin()
  " editor scheme
  Plug 'Luxed/ayu-vim'
  Plug 'itchyny/lightline.vim'

  " language support
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'fatih/vim-go'
  Plug 'Vimjas/vim-python-pep8-indent'

  " editor enhancement
  Plug 'airblade/vim-gitgutter'
  Plug 'cohama/lexima.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'

  " language server and completion
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
  call plug#end()
endfunction
