#!/usr/bin/env bash

cd /tmp
wget -O stow.tar.xz http://ftp.gnu.org/gnu/stow/stow-latest.tar.gz
mkdir stow && tar xvf stow.tar.xz -C stow --strip-components 1
cd stow

./configure --prefix $HOME/.local
make
make install
