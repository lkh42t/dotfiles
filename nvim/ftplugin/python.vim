if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" indent with 4-space
setl sts=4 sw=4

let b:undo_ftplugin = "setl sts< sw<"
