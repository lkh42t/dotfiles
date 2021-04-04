__swflutter_get_dir() {
	local flutterdir=~/.local/flutter
	echo $flutterdir
}

__swflutter_usage() {
	__switcher_base_usage swflutter flutter
}

# flutter version switcher
swflutter() {
	local cmd="$1"
	case $cmd in
	(get)
		__switcher_base_get_version "$(__swflutter_get_dir)"
		;;
	(help)
		__swflutter_usage
		;;
	(list)
		__switcher_base_list_versions "$(__swflutter_get_dir)"
		;;
	(set)
		__switcher_base_set_version "$(__swflutter_get_dir)" "$2"
		;;
	(*)
		echo unknown command: \'$cmd\' >&2
		__swflutter_usage
		return 1
		;;
	esac
}
