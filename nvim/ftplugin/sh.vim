if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" indent with tab
setl sts& sw& noet

let b:undo_ftplugin = "setl sts< sw< et<"
