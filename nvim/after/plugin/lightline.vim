let g:lightline = {
\ 'colorscheme': 'ayu',
\ 'active': {
\   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
\ },
\ 'component': {
\   'lineinfo': '%3l:%-2v%<',
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

function! s:is_window_narrow() abort
  return winwidth(0) <= 70
endfunction

function! s:string_fallback(value, fallback) abort
  return a:value !=# '' ? a:value : a:fallback
endfunction

function! LightlineFileencoding() abort
  return s:is_window_narrow() ? '' : s:string_fallback(&fenc, &enc)
endfunction

function! LightlineFileformat() abort
  return s:is_window_narrow() ? '' : &ff
endfunction

function! LightlineFilename() abort
  if s:is_window_narrow()
    return s:string_fallback(expand('%:t'), '[No Name]')
  endif
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root) - 1] ==# root
    return path[len(root) + 1:]
  endif
  return s:string_fallback(expand('%'), '[No Name]')
endfunction

function! LightlineFiletype() abort
  return s:is_window_narrow() ? '' : s:string_fallback(&ft, 'no ft')
endfunction
