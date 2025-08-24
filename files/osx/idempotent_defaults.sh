
# Wrapper for `defaults write` with idempotence
defaults() {
	local useSudo=""
	local currentHost=""
	local args=("$@")
	local type="${args[3]}"

	# Check for -currentHost
	if [[ "${args[0]}" == "-currentHost" ]]; then
		currentHost="-currentHost"
		args=("${args[@]:1}")  # shift arguments
	fi

	# Only handle write commands; pass everything else through
	if [[ "${args[0]}" != "write" ]]; then
		command defaults "$@"
		return
	fi

	# we can't handle -array, -array-add, -dict and -dict-add; pass everything else through
	if [[ "${type}" == "-array" || "${type}" == "-array-add" || "${type}" == "-dict" || "${type}" == "-dict-add" ]]; then
		echo "- We can't handle ${type} types. ${args[@]}"
		command defaults "$@"
		return
	fi

	local domain="${args[1]}"
	local key="${args[2]}"
	local new_value="${args[4]}"
	local new_value_normalized="${args[4]}"

	# Read current value
	local current
	if [[ -n "$currentHost" ]]; then
		current=$(defaults -currentHost read "$domain" "$key" 2>/dev/null)
	else
		current=$(defaults read "$domain" "$key" 2>/dev/null)
	fi

	# Normalize types for comparison
	case "$type" in
		-int|-integer|-float|-string) ;;
		-bool)
			if [[ "$current" == "1" || "$current" == "true" ]]; then
				current=1
			else
				current=0
			fi
			if [[ "$new_value" == "1" || "$new_value" == "true" ]]; then
				new_value_normalized=1
			else
				new_value_normalized=0
			fi
			;;
	esac

	# Skip if value is already correct
	if [[ "$current" == "$new_value_normalized" ]]; then
		echo "  ${domain} ${key} = '$current'"
		return
	fi

	# Build command as array
	local cmd=()
	[[ $use_sudo -eq 1 ]] && cmd+=(sudo)
	cmd+=(command defaults)
	[[ -n "$currentHost" ]] && cmd+=(-currentHost)
	cmd+=(write "$domain" "$key" "$type" "$new_value")

	# Execute
	"${cmd[@]}"

	echo "+ Changed ${domain} ${key}   '$current' => '$new_value'"
}

sudo_defaults() {
	# Run the current script's defaults function as root
	sudo bash -c "source ./idempotent_defaults.sh; defaults $*"
}
