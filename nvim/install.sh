#!/usr/bin/env bash

for pkg in libtool gettext wget; do
    command -v $pkg &> /dev/null || {
        echo "$pkg not installed!"
        exit
    }
done

neovim_dir="$HOME/neovim"
stow_dir="$(realpath ${BASH_SOURCE[0]})"
stow_dir=${stow_dir%/*/*}

# tag="v0.7.0"
tag="nightly"

packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if [ -d $neovim_dir ]; then
    echo ">>> Pulling the lateset neovim ..."
    cd $neovim_dir
    git pull --depth 1
else
    echo ">>> Cloneing neovim source code ..."
    git clone --depth 1 --branch "$tag" https://github.com/neovim/neovim $neovim_dir
    cd $neovim_dir
fi

echo ">>> Start building ..."
for program in make cmake unzip; do
    command -v $program &> /dev/null || {
        echo "Install $program before building!"
        exit
    }
done
make clean
make -j CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/
make install

if [ -d $packer_dir ]; then
    echo ">>> Pulling the lateset packer ..."
    cd $packer_dir
    git pull --depth 1
else
    echo ">>> Cloneing packer source code ..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
fi
cd $stow_dir
stow nvim
nvim --headless +PackerInstall +q
