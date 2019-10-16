let g:LanguageClient_serverCommands = {
            \ 'c': ['/usr/bin/clangd'],
            \ 'cpp': ['/usr/bin/clangd'],
            \ 'python': ['/usr/bin/pyls'],
            \ 'rust': ['/usr/bin/rls'],
            \ }

function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <silent>K :<C-u>call LanguageClient#textDocument_hover()<CR>
        nnoremap <silent>gd :<C-u>call LanguageClient#textDocument_definition()<CR>
        nnoremap <silent><F2> :<C-u>call LanguageClient#textDocument_rename()<CR>
        nnoremap <silent><Leader>f :<C-u>call LanguageClient#textDocument_formatting()<CR>
    endif
endfunction

autocmd FileType * call LC_maps()
