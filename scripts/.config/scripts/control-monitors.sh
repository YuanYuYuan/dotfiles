#!/usr/bin/env bash

intern="eDP-1"
extern="HDMI-A-2"

case "$1" in
    normal)
        # default, single eDP
        wlr-randr --output $intern --on --output $extern --off
        notify-send "Monitors Mode" "$intern only"
        ;;
    hdmi)
        # single HDMI
        wlr-randr --output $intern --off --output $extern --on
        notify-send "Monitors Mode" "$extern only"
        ;;
    mirror)
        # mirror
        wlr-randr --output $intern --on --output $extern --on
        notify-send "Monitors Mode" "$extern <-> $intern"
        ;;
    *)
        # default, single eDP
        wlr-randr --output $intern --on --output $extern --off
        notify-send "Monitors Mode" "$intern only"
        ;;
esac
exit 0
