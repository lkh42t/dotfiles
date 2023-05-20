XDG_CONFIG_HOME ?= $(HOME)/.config

XDG_COMPATIBLE_TARGETS := efm-langserver fontconfig nvim
XDG_INCOMPATIBLE_TARGETS := launchd vim zsh
ALL_TARGETS := $(XDG_COMPATIBLE_TARGETS) $(XDG_INCOMPATIBLE_TARGETS)

.PHONY: all config-home $(ALL_TARGETS)

all: $(ALL_TARGETS)

config-home:
	mkdir -p $(XDG_CONFIG_HOME)

$(XDG_COMPATIBLE_TARGETS): config-home
	ln -sf $(abspath $@) $(XDG_CONFIG_HOME)

launchd:
	mkdir -p $(HOME)/Library/LaunchAgents
	ln -sf $(abspath $(wildcard launchd/*)) $(HOME)/Library/LaunchAgents

vim:
	mkdir -p $(HOME)/.vim
	ln -sf $(abspath nvim/init.vim) $(HOME)/.vimrc
	ln -sf $(abspath $(filter-out nvim/init.vim, $(wildcard nvim/*))) $(HOME)/.vim

zsh:
	mkdir -p $(HOME)/.zsh
	ln -sf $(abspath zsh/zshrc) $(HOME)/.zshrc
	ln -sf $(abspath $(filter-out zsh/zshrc, $(wildcard zsh/*))) $(HOME)/.zsh
