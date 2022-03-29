__switcher_base_get_version() {
	local dir=$1
	readlink "$dir/default"
}

__switcher_base_list_versions() {
	local dir=$1
	local -a versions
	versions=($(find "$dir" -mindepth 1 -maxdepth 1 -type d | sed 's@^.*/@@'))
	for ver in "${versions[@]}"; do
		echo "$ver"
	done
}

__switcher_base_set_version() {
	local dir=$1
	local newver=$2
	if [[ ! $newver ]]; then
		echo missing version >&2
		return 1
	elif [[ ! -d $dir/$newver ]]; then
		echo unknown version >&2
		return 1
	fi
	rm -f "$dir/default"
	ln -sf "$newver" "$dir/default"
}

__switcher_base_usage() {
	local progname=$1
	cat <<EOF
Usage: $progname COMMAND

Commands:
	get		show current version
	help		show usage
	list		show available versions
	set VERSION	switch to the specified version
EOF
}
