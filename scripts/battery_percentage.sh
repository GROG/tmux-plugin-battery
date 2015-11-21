#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/shared.sh

pre_color=""
post_color=""
high_color=""
high_percentage=""
mid_color=""
mid_percentage=""
low_color=""
error_color=""
custom_percentage=""

d_pre_color=""
d_post_color="#[default]"
d_high_color="#[fg=colour2]"
d_high_percentage="75"
d_mid_color="#[fg=colour3]"
d_mid_percentage="35"
d_low_color="#[fg=colour1]"
d_error_color="#[fg=colour0]#[bg=colour1]"
d_custom_percentage=""

init_vars() {
    init_var "battery" "pre_color"
    init_var "battery" "post_color"
    init_var "battery" "high_color"
    init_var "battery" "high_percentage"
    init_var "battery" "mid_color"
    init_var "battery" "mid_percentage"
    init_var "battery" "low_color"
    init_var "battery" "error_color"
    init_var "battery" "custom_percentage"
}

battery_value() {
    if [ -x "$custom_percentage" ]; then
        eval "$custom_percentage"
    elif command_exists "pmset"; then
        pmset -g batt |\
        tail -1 |\
        awk '{print $2}' |\
        sed 's/[^0-9]*//g' |\
        awk '{printf("%02d\n", $1)}'
    elif command_exists "upower"; then
        for battery in $(upower -e | grep battery); do
            upower -i $battery |\
            grep percentage |\
            awk '{print $2}'
        done | xargs echo
    elif command_exists "acpi"; then
        acpi -b |\
        grep -Eo "[0-9]+%" |\
        awk '{printf("%02d\n", $1)}'
    fi
}

battery_percentage() {
    local battery_p=$(battery_value)

    if [ -z "$battery_p" ]; then
        print_color "error" "EE"
    elif [ "$battery_p" -gt "$high_percentage" ]; then
        print_color "high" "$battery_p"
    elif [ "$battery_p" -gt "$mid_percentage" ]; then
        print_color "mid" "$battery_p"
    else
        print_color "low" "$battery_p"
    fi
}

main() {
    init_vars
	battery_percentage
}
main
