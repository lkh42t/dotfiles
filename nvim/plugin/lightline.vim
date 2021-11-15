let g:lightline = {
\ 'colorscheme': 'breezy',
\ 'active': {
\   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
\ },
\ 'component_function': {
\   'fileencoding': 'LightlineFileencoding',
\   'fileformat': 'LightlineFileformat',
\   'filename': 'LightlineFilename',
\   'filetype': 'LightlineFiletype',
\   'gitbranch': 'FugitiveHead',
\ },
\ 'mode_map': {
\   'n': 'N',
\   'i': 'I',
\   'R': 'R',
\   'v': 'V',
\   'V': 'VL',
\   "\<C-v>": 'VB',
\   'c': 'C',
\   's': 'S',
\   'S': 'SL',
\   "\<C-s>": 'SB',
\   't': 'T',
\ },
\}

function s:is_window_narrow() abort
  return winwidth(0) <= 70
endfunction

function! LightlineFileencoding() abort
  return s:is_window_narrow() ? '' : &fenc !=# '' ? &fenc : &enc
endfunction

function! LightlineFileformat() abort
  return s:is_window_narrow() ? '' : &ff
endfunction

function! LightlineFilename() abort
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root) - 1] ==# root
    return path[len(root) + 1:]
  endif
  return expand('%')
endfunction

function! LightlineFiletype() abort
  return s:is_window_narrow() ? '' : &ft !=# '' ? &ft : 'no ft'
endfunction
