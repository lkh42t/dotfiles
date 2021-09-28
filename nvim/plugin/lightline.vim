let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ }

let g:lightline.active = {
      \ 'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'relativepath', 'modified']]
      \ }

let g:lightline.component_function = {
      \ 'fileencoding': 'LightlineFileencoding',
      \ 'fileformat': 'LightlineFileformat',
      \ 'filetype': 'LightlineFiletype',
      \ 'gitbranch': 'FugitiveHead',
      \ }

let g:lightline.mode_map = {
      \ 'n': 'N',
      \ 'i': 'I',
      \ 'R': 'R',
      \ 'v': 'V',
      \ 'V': 'VL',
      \ "\<C-v>": 'VB',
      \ 'c': 'C',
      \ 's': 'S',
      \ 'S': 'SL',
      \ "\<C-s>": 'SB',
      \ 't': 'T',
      \ }

fu s:is_window_narrow()
  retu winwidth(0) <= 70
endf

fu! LightlineFileencoding()
  retu s:is_window_narrow() ? '' : &fenc !=# '' ? &fenc : &enc
endf

fu! LightlineFileformat()
  retu s:is_window_narrow() ? '' : &ff
endf

fu! LightlineFiletype()
  retu s:is_window_narrow() ? '' : &ft !=# '' ? &ft : 'no ft'
endf
