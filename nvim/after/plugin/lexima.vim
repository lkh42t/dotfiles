if !exists("g:loaded_lexima") | finish | endif

" inline math mode of TeX
call lexima#add_rule({ 'char': '$', 'input_after': '$', 'filetype': 'tex' })
call lexima#add_rule({ 'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex' })
call lexima#add_rule({ 'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex' })
