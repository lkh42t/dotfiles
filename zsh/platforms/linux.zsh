DIFF_COLOR_OPT='--color=auto'

if [[ -f /etc/debian_version ]]; then
	SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

GIT_PS1_SRC=/usr/share/git/completion/git-prompt.sh

unload_variables() {
	unset DIFF_COLOR_OPT
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
