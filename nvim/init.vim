let g:mapleader = "\<space>"

" disable some built-in plugins
let s:disabled_builtins = ['gzip', 'netrw', 'netrwPlugin', 'tarPlugin', 'zipPlugin']
for s:el in s:disabled_builtins
  exe 'let g:loaded_' . s:el . '=1'
endfo

" plugins
lua require'plugins'

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
set showtabline=2
set showcmd
set noshowmode
set scrolloff=3
set showmatch
set splitright
set splitbelow
set foldmethod=marker
set updatetime=100
set clipboard=unnamedplus

" invisible characters
set list
set listchars=tab:>\ ,space:·

" completion
set shortmess+=c
set completeopt=menuone,noselect

" spacing
set expandtab     " use spaces instead of tabs
set shiftwidth=2  " indent width is 2
set softtabstop=2 " 2-space when <Tab> is pressed

" search
set hlsearch
set incsearch
set ignorecase " case-insensitive search when all characters is small
set smartcase  " case-sensitive when capitals are used
set inccommand=split

" LaTeX
let g:tex_flavor = 'latex'

" trim trailing whitespace
autocmd BufWritePre * :%s/\s\+$//ge

" color scheme
set termguicolors " use 24-bit true color
" set background=dark
colorscheme breezy
" }}}

" {{{ Keymaps
" more logical
nnoremap Y y$
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

nnoremap <silent> <Esc><Esc> <Cmd>nohlsearch<CR>

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
