#!/usr/bin/env nu

hyprctl dispatch togglegroup

if ((hyprctl activewindow -j | from json | get grouped | length) > 0)  {
    notify-send -t 600 -h string:x-canonical-private-synchronous:anything "Group mode" "ON"
} else {
    notify-send -t 600 -h string:x-canonical-private-synchronous:anything "Group mode" "OFF"
}
