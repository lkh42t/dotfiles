__swflutter_dir=~/.local/flutter
readonly __swflutter_dir

__swflutter_usage() {
	__switcher_base_usage swflutter
}

# flutter version switcher
swflutter() {
	local cmd=$1
	case $cmd in
	get)
		__switcher_base_get_version "$__swflutter_dir"
		;;
	help)
		__swflutter_usage
		;;
	list)
		__switcher_base_list_versions "$__swflutter_dir"
		;;
	set)
		__switcher_base_set_version "$__swflutter_dir" "$2"
		;;
	*)
		echo unknown command: \'"$cmd"\' >&2
		__swflutter_usage
		return 1
		;;
	esac
}
