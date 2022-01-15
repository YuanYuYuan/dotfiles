#!/usr/bin/env bash

git clone --depth 1 --branch v0.6.1 https://github.com/neovim/neovim $HOME/neovim
cd $HOME/neovim
make -j CMAKE_INSTALL_PREFIX=$HOME/.local/
make install
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
