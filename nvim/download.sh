#!/usr/bin/env bash

for pkg in curl; do
    command -v $pkg &> /dev/null || {
        echo "$pkg not installed!"
        exit
    }
done

# Download the latest release of nvim
base_dir=$HOME/.local
mkdir -p $base_dir
curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | tar -xz --strip 1 -C $base_dir

# Relocate to the project root
cd $(git rev-parse --show-toplevel)
stow nvim

# Install packages
$HOME/.local/bin/nvim --headless "+Lazy! sync" +qa
