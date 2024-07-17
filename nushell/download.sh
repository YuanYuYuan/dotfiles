#!/usr/bin/env bash

curl -L https://github.com/nushell/nushell/releases/download/0.95.0/nu-0.95.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz --strip 1 -C /tmp
cp /tmp/nu $HOME/.local/bin
