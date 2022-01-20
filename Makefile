XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

XDG_COMPAT_TARGETS := fontconfig nvim

all: $(XDG_COMPAT_TARGETS) zsh

config-home:
	mkdir -p $(XDG_CONFIG_HOME)

$(XDG_COMPAT_TARGETS): config-home
	ln -sf $(abspath $@) $(XDG_CONFIG_HOME)

zsh:
	mkdir -p $(HOME)/.zsh
	ln -sf $(abspath zsh/zshrc) $(HOME)/.zshrc
	ln -sf $(abspath $(filter-out zsh/zshrc, $(wildcard zsh/*))) $(HOME)/.zsh

.PHONY: all config-home $(XDG_COMPAT_TARGETS) zsh
