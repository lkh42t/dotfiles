include ./config.mk

UNAME_OS := $(shell uname -s)

XDG_CONFIG_TARGETS := efm-langserver fontconfig git nvim tmux
ALL_TARGETS := $(XDG_CONFIG_TARGETS)
ALL_TARGETS += vim zsh
ifeq ($(UNAME_OS),Darwin)
	SUBDIR_TARGETS += macos
else
	SUBDIR_TARGETS += kde
endif
ALL_TARGETS += $(SUBDIR_TARGETS)

.PHONY: all $(ALL_TARGETS)

all: $(ALL_TARGETS)

$(XDG_CONFIG_TARGETS): config-home
	ln -sf $(abspath $@) $(XDG_CONFIG_HOME)

$(SUBDIR_TARGETS):
	$(MAKE) -C $@

vim:
	mkdir -p $(HOME)/.vim
	ln -sf $(abspath nvim/init.vim) $(HOME)/.vimrc
	ln -sf $(abspath $(filter-out nvim/init.vim, $(wildcard nvim/*))) $(HOME)/.vim

zsh:
	mkdir -p $(HOME)/.zsh
	ln -sf $(abspath zsh/zshrc) $(HOME)/.zshrc
	ln -sf $(abspath $(filter-out zsh/zshrc, $(wildcard zsh/*))) $(HOME)/.zsh
