" init.vim

let mapleader = "\<space>"

" {{{ Plugins
call plug#begin('~/.cache/nvim-plugins')

" editor schemes
Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'

" languages support
Plug 'cespare/vim-toml', { 'for': 'toml' }

" editor enhancement
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim', { 'for': 'html' }

" language server
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()

" load setting per plugin
source <sfile>:h/plugins/coc.rc.vim
source <sfile>:h/plugins/lexima.rc.vim
source <sfile>:h/plugins/nerdtree.rc.vim
source <sfile>:h/plugins/nerdcommenter.rc.vim
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
set scrolloff=3
set showmatch
set splitright
set foldmethod=marker

set list
set listchars=tab:→\ ,space:･,

" spacing
set expandtab     " use spaces instead of tabs
set shiftwidth=2  " indent width is 2
set softtabstop=2 " 2-space when <Tab> is pressed

" search
set hlsearch
set incsearch  " enable incremental search
set ignorecase " case-insensitive search when all characters is small
set smartcase  " case-sensitive when capitals are used
set inccommand=split

" LaTeX
let g:tex_flavor = 'latex'

" trim trailing whitespace
autocmd BufWritePre * :%s/\s\+$//ge

augroup FileTypeIndent
  autocmd!
  " indent with 4-space
  autocmd FileType python setlocal sts=4 sw=4
  " indent with tab
  autocmd FileType sh setlocal sts& sw& noet
  autocmd FileType make setlocal sts& sw& noet
augroup END

" color scheme
set termguicolors " use 24-bit true color
colorscheme codedark
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
" }}}
