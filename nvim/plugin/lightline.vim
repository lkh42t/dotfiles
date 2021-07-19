let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ }

let g:lightline.active = {}
let g:lightline.active.left = [
      \ ['mode', 'paste'],  ['gitbranch', 'readonly', 'filename', 'modified'],
      \ ]

let g:lightline.component_function = {
      \ 'gitbranch': 'FugitiveHead',
      \ }
