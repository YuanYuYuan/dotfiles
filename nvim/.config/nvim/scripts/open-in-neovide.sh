#!/usr/bin/env bash

PIPE="$HOME/.cache/nvim/server.pipe"
FILE="$(realpath $1)"

[ -S $PIPE ] || {
    neovide -- --listen "$PIPE"
    sleep 1s
}
until [ -S $PIPE ]; do
    sleep 0.1s
    echo "Waiting for pipe established"
done

# If given the line number
if [[ -z $2 ]] then
    nvim --server "$PIPE" --remote "$FILE"
else
    nvim --server "$PIPE" --remote-send ":e $FILE | $2 <CR>zz"
fi
