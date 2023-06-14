#!/usr/bin/env bash

cmd_list="zsh git stow curl clang"
for cmd in $cmd_list; do
    command -v $cmd &> /dev/null || {
        echo "$cmd not found! Exiting..."
        echo "For Ubuntu users, try using: sudo apt install -y $cmd_list"
        exit
    }
done

# command -v cargo &> /dev/null || {
#     ./rust/install-rust.sh
# }

command -v starship &> /dev/null || {
    # cargo install --locked starship
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y
}

command -v z &> /dev/null || {
    # cargo install --locked zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- -y
}

cd $(git rev-parse --show-toplevel)
stow zsh
