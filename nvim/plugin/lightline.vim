let g:lightline = {
      \ 'colorscheme': 'breezy',
      \ }

let g:lightline.active = {
      \ 'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]
      \ }

let g:lightline.component_function = {
      \ 'fileencoding': 'LightlineFileencoding',
      \ 'fileformat': 'LightlineFileformat',
      \ 'filename': 'LightlineFilename',
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

fu! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root) - 1] ==# root
    retu path[len(root) + 1:]
  en
  retu expand('%')
endf

fu! LightlineFiletype()
  retu s:is_window_narrow() ? '' : &ft !=# '' ? &ft : 'no ft'
endf
