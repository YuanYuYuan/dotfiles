#!/usr/bin/env bash

for pkg in curl clang; do
    command -v $pkg &> /dev/null || {
        echo "$pkg not installed!"
        exit
    }
done

# Download the latest release of nvim
base_dir=$HOME/.local
curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | tar -xz --strip 1 -C $base_dir
