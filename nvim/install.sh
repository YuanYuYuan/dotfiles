#!/usr/bin/env bash

# tag="v0.6.1"
tag="nightly"
git clone --depth 1 --branch "$tag" https://github.com/neovim/neovim $HOME/neovim
cd $HOME/neovim
make -j CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/
make install

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
