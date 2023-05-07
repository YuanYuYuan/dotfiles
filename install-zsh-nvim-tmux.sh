#!/usr/bin/env bash

cd $HOME

[ "$EUID" == 0 ] && {
    apt update -y
    apt install -y stow git zsh tmux curl gcc g++
}

git clone https://github.com/YuanYuYuan/dotfiles
cd dotfiles

# tmux
stow tmux
ln -s $HOME/.config/tmux/tmux.conf $HOME/.tmux.conf

# zsh
cd $(git rev-parse --show-toplevel)
./zsh/install.sh

# nvim
cd $(git rev-parse --show-toplevel)
./nvim/download.sh
