LS_COLOR_OPT='-G'
GREP_COLOR_OPT='--color=auto'
DIFF_COLOR_OPT=''

SYNTAX_HIGHLIGHT_SRC="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

GIT_PS1_SRC=/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

fpath=($(brew --prefix)/share/zsh-completions $fpath)

unload_variables() {
	unset LS_COLOR_OPT GREP_COLOR_OPT DIFF_COLOR_OPT
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
