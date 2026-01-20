if [[ -f /etc/debian_version ]]; then
	SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	GIT_PS1_SRC=/usr/lib/git-core/git-sh-prompt
else
	SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	GIT_PS1_SRC=/usr/share/git/completion/git-prompt.sh
fi

unload_variables() {
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
