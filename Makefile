XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

all: fontconfig nvim zsh

fontconfig:
	mkdir -p "$(XDG_CONFIG_HOME)"
	ln -sf "$(abspath fontconfig)" "$(XDG_CONFIG_HOME)"

nvim:
	mkdir -p "$(XDG_CONFIG_HOME)"
	ln -sf "$(abspath nvim)" "$(XDG_CONFIG_HOME)"

zsh:
	mkdir -p "$(HOME)/.zsh"
	ln -sf "$(abspath zsh/zshrc)" "$(HOME)/.zshrc"
	ln -sf \
		"$(abspath zsh/functions)" \
		"$(abspath zsh/completions)" \
		"$(abspath zsh/platforms)" \
		"$(HOME)/.zsh"

.PHONY: all fontconfig nvim zsh
