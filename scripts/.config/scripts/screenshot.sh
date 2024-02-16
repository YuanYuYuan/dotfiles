#!/usr/bin/env bash

grim -g "$(slurp -d)" - | wl-copy
rm /tmp/screenshot.png &> /dev/null
wl-paste > /tmp/screenshot.png
