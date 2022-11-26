" Use builtin LSP for Neovim 0.5+
if has('nvim-0.5') | finish | endif

let g:lsp_diagnostics_float_cursor = 1

" servers {{{
if executable('bash-language-server')
  augroup lsp_bashls
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'bashls',
    \ 'cmd': {server_info->['bash-language-server', 'start']},
    \ 'allowlist': ['sh'],
    \})
  augroup END
endif

if executable('clangd')
  augroup lsp_clangd
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd']},
    \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto'],
    \})
  augroup END
endif

if executable('dart')
  augroup lsp_dart
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'dart',
    \ 'cmd': {server_info->['dart', 'language-server', '--protocol=lsp']},
    \ 'allowlist': ['dart'],
    \ 'initialization_options': {
    \   'onlyAnalyzeProjectsWithOpenFiles': v:true,
    \   'suggestFromUnimportedLibraries': v:true,
    \   'closingLabels': v:true,
    \   'outline': v:true,
    \   'flutterOutline': v:true,
    \ },
    \ 'workspace_config': {
    \   'completeFunctionCalls': v:true,
    \   'enableSnippets': v:true,
    \   'showTodos': v:true,
    \ },
    \})
  augroup END
endif

if executable('efm-langserver')
  augroup lsp_efm_langserver
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'efm',
    \ 'cmd': {server_info->['efm-langserver']},
    \ 'allowlist': [
    \   'css',
    \   'javascript',
    \   'javascriptreact',
    \   'lua',
    \   'rst',
    \   'sh',
    \   'typescript',
    \   'typescriptreact',
    \   'yaml',
    \   'zsh',
    \  ],
    \})
  augroup END
endif

if executable('gopls')
  augroup lsp_gopls
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'gopls',
    \ 'cmd': {server_info->['gopls', '-remote=auto']},
    \ 'allowlist': ['go'],
    \ 'initialization_options': {
    \   'gofumpt': v:true,
    \   'staticcheck': v:true,
    \   'usePlaceholders': v:true,
    \ },
    \})
  augroup END
endif

if executable('pylsp')
  augroup lsp_pylsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'pylsp',
    \ 'cmd': {server_info->['pylsp']},
    \ 'allowlist': ['python'],
    \ 'workspace_config': {
    \   'pylsp': {
    \     'configurationSources': ['flake8'],
    \     'plugins': {
    \       'flake8': {'enabled': v:true},
    \       'mccabe': {'enabled': v:false},
    \       'pycodestyle': {'enabled': v:false},
    \       'pyflakes': {'enabled': v:false},
    \     },
    \   },
    \ },
    \})
  augroup END
endif

if executable('rust-analyzer')
  augroup lsp_rust_analyzer
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'rust_analyzer',
    \ 'cmd': {server_info->['rust-analyzer']},
    \ 'allowlist': ['rust'],
    \})
  augroup END
endif

if executable('texlab')
  augroup lsp_texlab
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'texlab',
    \ 'cmd': {server_info->['texlab']},
    \ 'allowlist': ['bib', 'plaintex', 'tex'],
    \ 'workspace_config': {
    \   'texlab': {
    \     'build': {
    \       'executable': 'llmk',
    \       'args': [],
    \     },
    \     'chktex': {'onOpenAndSave': v:true},
    \   },
    \ },
    \})
  augroup END
endif

if executable('vim-language-server')
  augroup lsp_vimls
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'vimls',
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
  augroup END
endif

if executable('yaml-language-server')
  augroup lsp_yamlls
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'yamlls',
    \ 'cmd': {server_info->['yaml-language-server', '--stdio']},
    \ 'allowlist': ['yaml'],
    \ 'workspace_config': {
    \   'redhat': {
    \     'telemetry': {'enabled': v:false},
    \   },
    \ },
    \})
  augroup END
endif
" }}}

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
