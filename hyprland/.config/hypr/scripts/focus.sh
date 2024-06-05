#!/usr/bin/env bash

case $1 in
    forward)
        is_forward=true
        ;;
    backward)
        is_forward=false
        ;;
esac

if [ $(hyprctl activewindow -j | jq '.grouped | length') -lt 2 ]; then
    if [ $is_forward = true ]; then
        hyprctl dispatch movefocus d
    else
        hyprctl dispatch movefocus u
    fi
else
    if [ $is_forward = true ]; then
        hyprctl dispatch changegroupactive f
    else
        hyprctl dispatch changegroupactive b
    fi
fi
hyprctl dispatch bringactivetotop
