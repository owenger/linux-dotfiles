alias cdd="cd ~/git/robotics_software"
alias cdw="cd ~/git/wedding-jessi-oli/"
alias dcu="docker compose up --remove-orphans"
alias dcud="docker compose up -d --remove-orphans"
alias senter="sh ~/git/robotics_software/enter.sh"

# git commands
function gacm() {
	git add .
	git commit -m "$1"
}

# powershell
alias powershell="pwsh-preview"

# Kill all docker containers.
alias killdockers='dps=$(dps); docker stop ${dps} && docker rm ${dps}'

# Stop all docker containers
alias stopdockers='docker stop $(docker ps -a -q)'

# set audio input/output
alias setsound='pavucontrol'

# remove docker network cache
alias rmdockernet='sudo rm -rf /var/lib/docker/network'

# set mtu to 1450 for specific network interface
netmtu_interface() {
	if [ "$#" -ne 1 ]; then
		echo "Usage: setmtu <interface>"
		return 1
	fi

	sudo ip link set dev "$1" mtu 1450
}

setmtu() {
  local interface_name=$(ip -br -4 a | grep -oP 'wlp\S+')
  sudo ip link set dev "$interface_name" mtu 1450
  echo "Set interface $interface_name mtu to 1450"
}

# move the wg0.conf file for wireguard connection to correct place
alias mvwg='sudo mv ~/Downloads/wg0.conf /etc/wireguard'
alias sswg='sudo wg-quick down wg0; sudo wg-quick up wg0'

# Replace a text-based key-value pair in a file with a different value.
#
# Syntax variations allowed:
# - Single or double quotes around the key and/or the value strings.
# - A separator ':' or '='.
# - Whitespace between tokens.
# - A comma at the end of the pair.
#
# Working examples:
# - "pylon_enable": false,
# - "ROS_MASTER_URI=http://localhost:11311"
# - DEV_RESERVED=username
#
# Usage: replaceFileParam <FILE> <KEY> <NEW_VALUE>
function replaceFileParam() {
	file=${1:-}
	key=${2:-}
	value=${3:-}

	# File not found.
	if [ ! -f "${file}" ]; then
		echo Invalid file: ${file}
		return
	fi

	# No match in file.
	match=$(grep -E "\W${key}\W" "${file}")
	if [ -z "${match}" ]; then return; fi

	# Print pre-contents.
	echo ${file}
	echo Was:
	grep -E "${key}" "${file}"

	# Modify value in file.
	sed -E "s|(['\"]? *${key} *['\"]? *[:=] *['\"]? *)[^'\",]*(['\"]?) *(,?)|\1${value}\2\3|g" -i "${file}"

	# Print post-contents.
	echo Is:
	grep -E "${key}" "${file}"
	echo
}

alias 😴='sleep 360'
