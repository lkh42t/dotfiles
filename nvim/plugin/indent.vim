augroup my_indent
  autocmd!
  autocmd FileType python setl sts=4 sw=4
  autocmd FileType go,make,sh,zsh setl sts& sw& noet
augroup END
