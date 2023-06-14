#!/usr/bin/env bash

cd /tmp
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
mkdir zsh && tar xvf zsh.tar.xz -C zsh --strip-components 1
cd zsh

./configure --prefix $HOME/.local
make
make install
