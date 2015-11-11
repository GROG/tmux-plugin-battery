#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

battery_percentage="#($CURRENT_DIR/scripts/battery_percentage.sh)"
battery_percentage_i="\#{battery_percentage}"

source $CURRENT_DIR/scripts/shared.sh

do_interpolation() {
	local string="$1"
	local interpolated="${string/$battery_percentage_i/$battery_percentage}"
	echo "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
