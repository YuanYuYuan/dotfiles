#!/usr/bin/env bash

for cmd in zsh git stow curl; do
    command -v $cmd &> /dev/null || {
        echo "$cmd not found! Exiting..."
        exit
    }
done

dotfiles_dir=$(git rev-parse --show-toplevel)

cd $dotfiles_dir

command -v cargo &> /dev/null || {
    ./rust/install-rust.sh
}

command -v starship &> /dev/null || {
    cargo install --locked starship
}

command -v z &> /dev/null || {
    cargo install --locked zoxide
}

stow zsh
