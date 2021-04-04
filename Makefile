XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

all: zsh nvim

zsh:
	mkdir -p "$(HOME)/.zsh"
	ln -sf "$(abspath zsh/zshrc)" "$(HOME)/.zshrc"
	ln -sf \
		"$(abspath zsh/functions)" \
		"$(abspath zsh/completions)" \
		"$(HOME)/.zsh"

nvim:
	ln -sf "$(abspath nvim)" "$(XDG_CONFIG_HOME)"
	curl -fL "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
		-o "$(XDG_DATA_HOME)/nvim/site/autoload/plug.vim" --create-dirs

.PHONY: all zsh nvim
