XDG_CONFIG_HOME ?= $(HOME)/.config

XDG_COMPAT_TARGETS := efm-langserver fontconfig nvim
NO_XDG_COMPAT_TARGETS := vim zsh
ALL_TARGETS := $(XDG_COMPAT_TARGETS) $(NO_XDG_COMPAT_TARGETS)

.PHONY: all config-home $(ALL_TARGETS)

all: $(ALL_TARGETS)

config-home:
	mkdir -p $(XDG_CONFIG_HOME)

$(XDG_COMPAT_TARGETS): config-home
	ln -sf $(abspath $@) $(XDG_CONFIG_HOME)

vim:
	mkdir -p $(HOME)/.vim
	ln -sf $(abspath nvim/init.vim) $(HOME)/.vimrc
	ln -sf $(abspath $(filter-out nvim/init.vim, $(wildcard nvim/*))) $(HOME)/.vim

zsh:
	mkdir -p $(HOME)/.zsh
	ln -sf $(abspath zsh/zshrc) $(HOME)/.zshrc
	ln -sf $(abspath $(filter-out zsh/zshrc, $(wildcard zsh/*))) $(HOME)/.zsh
