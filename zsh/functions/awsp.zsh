awsp() {
	local usage='Usage: awsp COMMAND

Commands:
	get		get current profile
	help		show usage
	list		show available profiles
	reset		reset to default profile
	set PROFILE	set profile'

	local config_file=${AWS_CONFIG_FILE:-$HOME/.aws/config}

	local cmd=$1
	case $cmd in
	get)
		echo "${AWS_PROFILE:-default}"
		;;
	help)
		echo "$usage" >&2
		;;
	list)
		if [[ -f $config_file ]]; then
			{
				sed -n 's/^\[profile \(.*\)\]$/\1/p' "$config_file"
				echo 'default'
			} | sort -u
		fi
		;;
	reset)
		unset AWS_PROFILE
		;;
	set)
		if [[ -z $2 ]]; then
			echo 'awsp: requires an argument' >&2
			return 1
		fi
		export AWS_PROFILE="$2"
		;;
	*)
		echo "awsp: unknown subcommand: '$cmd'" >&2
		echo "$usage" >&2
		return 1
		;;
	esac
}
