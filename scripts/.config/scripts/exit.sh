#!/usr/bin/env bash

# i3lock

wallpaper="~/.xmonad/pic/lockscreen.png"

lock() {
    xset dpms force off
    xset dpms 10
    # i3lock -e -n -i $wallpaper
    hyprlock
    xset dpms 360
}

output_sink="$(pactl list short sinks | grep output | head -n1 | cut -f2)"

case "$1" in
    lock)
        lock
        ;;
    logout )
        pkill -x Xorg
        ;;
    suspend)
        pactl set-sink-mute $output_sink 1
        systemctl suspend&
        lock
        pactl set-sink-mute $output_sink 0
        ;;
    # reboot)
    #     systemctl reboot
    #     ;;
    # shutdown)
    #     systemctl poweroff
    #     ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
esac
exit 0
