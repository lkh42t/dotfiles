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
set colorcolumn=80,100,120
set cursorline
set foldmethod=marker
set noshowmode
set number
set scrolloff=3
set showmatch
set showtabline=2
set splitbelow
set splitright
set updatetime=100

" clipboard
set clipboard=unnamedplus

" invisible characters
set list
set listchars=tab:>\ ,space:∙

" completion
set shortmess+=c
set completeopt=menuone,noinsert,noselect

" indent
set expandtab     " use spaces instead of tabs
set shiftwidth=2  " indent width is 2
set softtabstop=2 " 2-space when <Tab> is pressed

" search
set ignorecase " case-insensitive search when all characters is small
set smartcase  " case-sensitive when capitals are used
set inccommand=split

" LaTeX
let g:tex_flavor = 'latex'

" color scheme
set termguicolors " use 24-bit true color
set background=dark
let g:ayucolor = 'dark'
colorscheme ayu
" highlight for listchars based on vscode-ayu
hi NonText guifg=#6c7380
hi SpecialKey guifg=#6c7380
" }}}

" Keymaps {{{
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

tnoremap <Esc> <C-\><C-n>

" emacs like keybinding for command-line mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
" }}}

" autocmd {{{
augroup FiletypeIndent
  autocmd!
  autocmd FileType python setl sts=4 sw=4
  autocmd FileType go,make,sh,zsh setl noet sts& sw&
augroup END

" trim trailing whitespace
autocmd BufWritePre * :%s/\s\+$//ge
" }}}
