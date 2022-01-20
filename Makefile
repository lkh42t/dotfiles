XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

all: fontconfig nvim zsh

config-home:
	mkdir -p "$(XDG_CONFIG_HOME)"

fontconfig: config-home
	ln -sf "$(abspath fontconfig)" "$(XDG_CONFIG_HOME)"

nvim: config-home
	ln -sf "$(abspath nvim)" "$(XDG_CONFIG_HOME)"

zsh:
	mkdir -p "$(HOME)/.zsh"
	ln -sf "$(abspath zsh/zshrc)" "$(HOME)/.zshrc"
	ln -sf \
		"$(abspath zsh/functions)" \
		"$(abspath zsh/completions)" \
		"$(abspath zsh/platforms)" \
		"$(HOME)/.zsh"

.PHONY: all config-home fontconfig nvim zsh
