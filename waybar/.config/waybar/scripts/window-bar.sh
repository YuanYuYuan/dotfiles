#!/usr/bin/env bash

# Terminate the socat if waybar has been killed
set -e

function update_bar() {
    info=$(hyprctl activewindow -j)
    title=$(echo $info | jq '.title' | tr -d '"')
    if [[ $title == "null" ]]; then
        echo ""
        return
    fi

    is_grouped=$(echo $info | jq '.grouped != []')
    if $is_grouped == "true"; then
        num_windows_in_group=$(echo $info | jq '.grouped | length')
        curr_addr=$(echo $info | jq '.address')
        curr_idx=$(echo $info | jq ".grouped | index($curr_addr)")
        for i in $(seq 0 $((curr_idx-1))); do echo -n ' • '; done
        echo -n "[$title]"
        for i in $(seq $((curr_idx+1)) $((num_windows_in_group-1))); do echo -n ' • '; done
        echo
    else
        echo $title
    fi
}

# We need to make socat be unidirectional, otherwise it will terminate immediately if not running within a terminal
# Ref: https://unix.stackexchange.com/a/218597
socat -u UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock STDOUT | while read -r l ; do update_bar ; done
