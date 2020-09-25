map <silent><M-e> :<C-u>NERDTreeToggle<CR>

autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
