" setup plugin manager
let s:dein_cache_dir = expand('~/.cache/dein/')
let s:dein_dir = s:dein_cache_dir . 'repos/github.com/Shougo/dein.vim'
if &runtimepath !~# 'dein.vim'
    if !isdirectory(s:dein_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)

    let s:toml_dir = expand('~/.config/nvim/toml/')
    call dein#load_toml(s:toml_dir . 'base.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . 'lazy.toml', {'lazy': 1})
    call dein#load_toml(s:toml_dir . 'lang.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
