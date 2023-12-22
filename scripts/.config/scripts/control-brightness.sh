#!/usr/bin/env bash

source $XMONAD_HOME/scripts/check_cmd.sh
# check_cmd xbacklight xorg-xbacklight
xorg-xbacklight

function get_brightness {
    xbacklight -get | cut -d '.' -f 1
}

function send_notification {
    val=$(get_brightness)
    bar=$(seq -s "─" 0 $((val / 5)) | sed 's/[0-9]//g')
    dunstify -t 600 -r 5555 -u normal " $val $bar"
}

case $1 in
    up)
        xbacklight -inc 5
        ;;
    down)
        xbacklight -dec 5
        ;;
esac
send_notification
