GNU_COLOR_OPT='--color=auto'
LS_COLOR_OPT="$GNU_COLOR_OPT"
GREP_COLOR_OPT="$GNU_COLOR_OPT"
DIFF_COLOR_OPT="$GNU_COLOR_OPT"

SYNTAX_HIGHLIGHT_SRC=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

GIT_PS1_SRC=/usr/share/git/completion/git-prompt.sh

unload_variables() {
	unset GNU_COLOR_OPT LS_COLOR_OPT GREP_COLOR_OPT DIFF_COLOR_OPT
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
