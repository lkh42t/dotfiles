if has('nvim-0.5') | finish | endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
\ 'name': 'buffer',
\ 'allowlist': ['*'],
\ 'completor': function('asyncomplete#sources#buffer#completor'),
\}))

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
\ 'name': 'file',
\ 'allowlist': ['*'],
\ 'priority': 10,
\ 'completor': function('asyncomplete#sources#file#completor'),
\}))
