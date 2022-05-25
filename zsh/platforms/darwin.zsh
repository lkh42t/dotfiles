DIFF_COLOR_OPT=''

GIT_PS1_SRC=/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

if [[ -d /opt/homebrew/bin ]]; then
	path=(/opt/homebrew/bin $path)

	SYNTAX_HIGHLIGHT_SRC=$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	fpath=($(brew --prefix)/share/{zsh/site-functions,zsh-completions} $fpath)
fi

unload_variables() {
	unset DIFF_COLOR_OPT
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
