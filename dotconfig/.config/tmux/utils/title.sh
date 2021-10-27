#!/bin/sh

if [ "$1" == "zsh" ]; then
    if [ "$2" == "$HOME" ]; then
        title="~"
    else
        title=$(echo "$2" | xargs basename)
    fi
else
    title=$1
fi

echo $title
