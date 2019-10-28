function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

nmap <silent><F2> <Plug>(coc-rename)
nmap <silent><leader>f <Plug>(coc-format)
nmap <silent><leader>gd <Plug>(coc-references)
