let g:mapleader = "\<space>"

" disable some built-in plugins {{{
let s:builtins = ['gzip', 'netrw', 'netrwPlugin', 'tarPlugin', 'zipPlugin']
for s:e in s:builtins
  execute 'let g:loaded_' . s:e . '=1'
endfor
" }}}

" plugins {{{
lua require'plugins'
" }}}

" Editor Settings {{{
filetype plugin indent on
syntax on

set noswapfile
set nobackup

" utf-8 as default
set fileencodings=utf-8,cp932,default
" use `<LF>` for line ending
set fileformats=unix,dos

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
set listchars=tab:>\ ,space:∙

" completion
set shortmess+=c
set completeopt=menuone,noinsert,noselect

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
set background=dark
let g:ayucolor = 'dark'
colorscheme ayu
" fix for listchars based on vscode-ayu
hi NonText guifg=#6c7380
hi SpecialKey guifg=#6c7380
" }}}

" Keymaps {{{
nnoremap Y y$
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

nnoremap <silent> <Esc><Esc> <Cmd>nohlsearch<CR>

tnoremap <Esc> <C-\><C-n>

cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
" }}}
