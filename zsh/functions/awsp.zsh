__awsp_usage() {
	cat <<EOF
Usage: awsp COMMAND

Commands:
	get		get current profile
	help		show usage
	list		show available profiles
	reset		reset to default profile
	set PROFILE	set profile
EOF
}

awsp() {
	local credentials_file=${AWS_SHARED_CREDENTIALS_FILE:-$HOME/.aws/credentials}

	local cmd=$1
	case $cmd in
	get)
		echo "${AWS_PROFILE:-default}"
		;;
	help)
		__awsp_usage
		;;
	list)
		if [[ -f $credentials_file ]]; then
			sed -n 's/^\[\(.*\)\]$/\1/p' "$credentials_file" | sort -u
		fi
		;;
	reset)
		unset AWS_PROFILE
		;;
	set)
		if [[ -z $2 ]]; then
			echo awsp: requires an argument >&2
			return 1
		fi
		export AWS_PROFILE="$2"
		;;
	*)
		echo awsp: unknown subcommand: "'$cmd'" >&2
		__awsp_usage
		return 1
		;;
	esac
}
