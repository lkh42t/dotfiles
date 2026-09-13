include ./config.mk

XDG_CONFIG_TARGETS := efm-langserver fontconfig git nvim tmux
ALL_TARGETS := $(XDG_CONFIG_TARGETS)
ALL_TARGETS += vim zsh

.PHONY: all gui $(ALL_TARGETS)

all: $(ALL_TARGETS)

gui:
	@case $$(uname -s) in \
	Darwin) $(MAKE) -C macos; ;; \
	*) $(MAKE) -C kde; ;; \
	esac

$(XDG_CONFIG_TARGETS): config-home
	ln -sf $(abspath $@) $(XDG_CONFIG_HOME)

vim:
	mkdir -p $(HOME)/.vim
	ln -sf $(abspath nvim/init.vim) $(HOME)/.vimrc
	ln -sf $(abspath $(filter-out nvim/init.vim, $(wildcard nvim/*))) $(HOME)/.vim

zsh:
	mkdir -p $(HOME)/.zsh
	ln -sf $(abspath zsh/zshrc) $(HOME)/.zshrc
	ln -sf $(abspath $(filter-out zsh/zshrc, $(wildcard zsh/*))) $(HOME)/.zsh
