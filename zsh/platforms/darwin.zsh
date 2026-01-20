GIT_PS1_SRC=/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

if [[ -d /opt/homebrew/bin ]]; then
	if [[ -z $HOMEBREW_PREFIX ]]; then
		eval "$(/opt/homebrew/bin/brew shellenv)"
	fi

	[[ -x $HOMEBREW_PREFIX/bin/git ]] && GIT_PS1_SRC=$HOMEBREW_PREFIX/opt/git/etc/bash_completion.d/git-prompt.sh
	SYNTAX_HIGHLIGHT_SRC=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $HOMEBREW_PREFIX/share/zsh-completions $fpath)
fi

unload_variables() {
	unset SYNTAX_HIGHLIGHT_SRC
	unset GIT_PS1_SRC
	unset -f unload_variables
}
