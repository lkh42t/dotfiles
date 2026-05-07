if [[ -f /etc/debian_version ]]; then
	SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

unload_variables() {
	unset SYNTAX_HIGHLIGHT_SRC
	unset -f unload_variables
}
