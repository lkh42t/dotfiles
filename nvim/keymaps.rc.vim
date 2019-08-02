" keymap.rc.vim

" Window
nnoremap <M-Up>    <C-w>k
nnoremap <M-Down>  <C-w>j
nnoremap <M-Right> <C-w>l
nnoremap <M-Left>  <C-w>h
nnoremap <M-h>     <C-w>h
nnoremap <M-j>     <C-w>j
nnoremap <M-k>     <C-w>k
nnoremap <M-l>     <C-w>l

" Cursor
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap <leader>h ^
nnoremap <leader>l $

nnoremap Y y$

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

tnoremap <Esc> <C-\><C-n>
