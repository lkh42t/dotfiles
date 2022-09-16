DIFF_COLOR_OPT=''

GIT_PS1_SRC=/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

if [[ -d /opt/homebrew/bin ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"

	SYNTAX_HIGHLIGHT_SRC=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $HOMEBREW_PREFIX/share/zsh-completions $fpath)
fi

unload_variables() {
	unset DIFF_COLOR_OPT
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
