all: zsh nvim

zsh:
	ln -sf "$(abspath zsh/zshrc)"       "$(HOME)/.zshrc"
	ln -sf "$(abspath zsh/zsh_aliases)" "$(HOME)/.zsh_aliases"
	ln -sf "$(abspath zsh/zsh_keys)"    "$(HOME)/.zsh_keys"
	ln -sf "$(abspath zsh/zsh_prompt)"  "$(HOME)/.zsh_prompt"

nvim:
	ln -sf "$(abspath nvim)" "$(HOME)/.config"
	curl -fL "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
		-o "$(HOME)/.local/share/nvim/site/autoload/plug.vim" --create-dirs

.PHONY: all zsh nvim
