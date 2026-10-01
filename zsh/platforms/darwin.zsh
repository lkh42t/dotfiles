SYNTAX_HIGHLIGHT_SRC=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unload_variables() {
	unset SYNTAX_HIGHLIGHT_SRC
	unset -f unload_variables
}
