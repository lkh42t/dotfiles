all: zsh nvim

zsh:
	ln -sf "$(abspath zsh/zshrc)"       "$(HOME)/.zshrc"
	ln -sf "$(abspath zsh/zsh_aliases)" "$(HOME)/.zsh_aliases"
	ln -sf "$(abspath zsh/zsh_keys)"    "$(HOME)/.zsh_keys"
	ln -sf "$(abspath zsh/zsh_prompt)"  "$(HOME)/.zsh_prompt"

nvim:
	ln -sf "$(abspath nvim)" "$(HOME)/.config"

.PHONY: all zsh nvim
