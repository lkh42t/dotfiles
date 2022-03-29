__swtex_dir=~/.local/texlive
readonly __swtex_dir

__swtex_list_versions() {
	local -a versions
	versions=($(find "$__swtex_dir" -mindepth 1 -maxdepth 1 -type d -not -name texmf-local | sed 's@^.*/@@'))
	for ver in "${versions[@]}"; do
		echo "$ver"
	done
}

__swtex_usage() {
	__switcher_base_usage swtex
}

# texlive version switcher
swtex() {
	local cmd=$1
	case $cmd in
	get)
		__switcher_base_get_version "$__swtex_dir"
		;;
	help)
		__swtex_usage
		;;
	list)
		__swtex_list_versions
		;;
	set)
		__switcher_base_set_version "$__swtex_dir" "$2"
		;;
	*)
		echo unknown command: \'"$cmd"\' >&2
		__swtex_usage
		return 1
		;;
	esac
}
