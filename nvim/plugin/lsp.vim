" Use builtin lsp for Nvim 0.5+
if has('nvim-0.5') | finish | endif

let g:lsp_diagnostics_float_cursor = 1

if executable('vim-language-server')
  autocmd User lsp_setup call lsp#register_server({
  \ 'name': 'vim-language-server',
  \ 'cmd': {server_info->['vim-language-server', '--stdio']},
  \ 'allowlist': ['vim'],
  \ 'initialization_options': {
  \   'isNeovim': has('nvim'),
  \   'iskeyword': &isk . ',:',
  \   'vimruntime': $VIMRUNTIME,
  \   'runtimepath': &rtp,
  \   'diagnostic': {'enable': v:true},
  \   'indexes': {
  \     'runtimepath': v:true,
  \     'gap': 100,
  \     'count': 3,
  \   },
  \   'suggest': {
  \     'fromVimruntime': v:true,
  \     'fromRuntimepath': v:true,
  \   },
  \ },
  \})
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> K <Plug>(lsp-hover)
  nmap <buffer> <Leader>ca <Plug>(lsp-code-action)
  nmap <buffer> <Leader>e <Plug>(lsp-document-diagnostics)
  nmap <buffer> <Leader>f <Plug>(lsp-document-format)
  nmap <buffer> <Leader>gd <Plug>(lsp-definition)
  nmap <buffer> <Leader>gD <Plug>(lsp-declaration)
  nmap <buffer> <Leader>gi <Plug>(lsp-implementation)
  nmap <buffer> <Leader>gr <Plug>(lsp-references)
  nmap <buffer> <Leader>rn <Plug>(lsp-rename)
  nmap <buffer> <Leader>td <Plug>(lsp-type-definition)
  nmap <buffer> [d <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <Plug>(lsp-next-diagnostic)
  nnoremap <buffer> <expr><C-D> lsp#scroll(-4)
  nnoremap <buffer> <expr><C-F> lsp#scroll(+4)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
