XDG_CONFIG_HOME ?= $(HOME)/.config

UNAME_OS := $(shell uname -s)

XDG_CONFIG_TARGETS := efm-langserver fontconfig git nvim tmux
NON_XDG_CONFIG_TARGETS := vim zsh
ifeq ($(UNAME_OS),Darwin)
	NON_XDG_CONFIG_TARGETS += launchd
endif
ALL_TARGETS := $(XDG_CONFIG_TARGETS) $(NON_XDG_CONFIG_TARGETS)

.PHONY: all config-home $(ALL_TARGETS)

all: $(ALL_TARGETS)

config-home:
	mkdir -p $(XDG_CONFIG_HOME)

$(XDG_CONFIG_TARGETS): config-home
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
