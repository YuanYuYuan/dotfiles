#!/usr/bin/env bash

cmd_list="zsh git stow curl"
for cmd in $cmd_list; do
    command -v $cmd &> /dev/null || {
        echo "$cmd not found! Exiting..."
        echo "For Ubuntu users, try using: sudo apt install -y $cmd_list"
        exit
    }
done

dotfiles_dir=$(git rev-parse --show-toplevel)

cd $dotfiles_dir

# command -v cargo &> /dev/null || {
#     ./rust/install-rust.sh
# }

command -v starship &> /dev/null || {
    # cargo install --locked starship
    curl -sS https://starship.rs/install.sh | sh
}

command -v z &> /dev/null || {
    # cargo install --locked zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
}

stow zsh
zsh