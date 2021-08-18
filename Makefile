XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

all: nvim zsh

nvim:
	mkdir -p "$(XDG_CONFIG_HOME)"
	ln -sf "$(abspath nvim)" "$(XDG_CONFIG_HOME)"
	git clone https://github.com/wbthomason/packer.nvim \
		"$(XDG_DATA_HOME)/nvim/site/pack/packer/start/packer.nvim"

zsh:
	mkdir -p "$(HOME)/.zsh"
	ln -sf "$(abspath zsh/zshrc)" "$(HOME)/.zshrc"
	ln -sf \
		"$(abspath zsh/functions)" \
		"$(abspath zsh/completions)" \
		"$(HOME)/.zsh"

.PHONY: all nvim zsh
