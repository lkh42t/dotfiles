" init.vim
let mapleader = "\<space>"

" {{{ Plugins
call plug#begin('~/.cache/nvim-plugins')

" editor schemes
Plug 'fneu/breezy'
Plug 'itchyny/lightline.vim'

" languages support
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'JuliaEditorSupport/julia-vim'
Plug 'dart-lang/dart-vim-plugin'

" editor enhancement
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'cohama/lexima.vim'
" Plug 'mattn/emmet-vim', { 'for': 'html' }

" language server
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()
" }}}

" {{{ Editor Settings
filetype plugin indent on
syntax on

set noswapfile
set nobackup

" utf-8 as default
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,default
" use `<LF>` for line ending
set fileformat=unix

" general
set number
set hidden
set autoread
set cursorline
set colorcolumn=80,100,120
set laststatus=2
set showcmd
set noshowmode
set scrolloff=3
set showmatch
set splitright
set foldmethod=marker

set list
set listchars=tab:>\ ,space:·,

" spacing
set autoindent
set smartindent
set expandtab     " use spaces instead of tabs
set shiftwidth=2  " indent width is 2
set softtabstop=2 " 2-space when <Tab> is pressed

" search
set hlsearch
set incsearch  " enable incremental search
set ignorecase " case-insensitive search when all characters is small
set smartcase  " case-sensitive when capitals are used
set inccommand=split

" disable netrw history
let g:netrw_dirhistmax = 0

" LaTeX
let g:tex_flavor = 'latex'

" trim trailing whitespace
autocmd BufWritePre * :%s/\s\+$//ge

" color scheme
set termguicolors " use 24-bit true color
set background=dark
colorscheme breezy
" }}}

" {{{ Keymaps
nnoremap Y y$
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap <leader>h ^
nnoremap <leader>l $
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <M-h>     <C-w>h
nnoremap <M-Left>  <C-w>h
nnoremap <M-j>     <C-w>j
nnoremap <M-Down>  <C-w>j
nnoremap <M-k>     <C-w>k
nnoremap <M-Up>    <C-w>k
nnoremap <M-l>     <C-w>l
nnoremap <M-Right> <C-w>l
tnoremap <Esc> <C-\><C-n>
" }}}
