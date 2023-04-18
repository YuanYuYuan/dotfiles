#!/usr/bin/env bash

for pkg in wget; do
    command -v $pkg &> /dev/null || {
        echo "$pkg not installed!"
        exit
    }
done

# Download the latest release of nvim
base_dir=$HOME/.local
mkdir -p $base_dir
curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | tar -xz --strip 1 -C $base_dir

# Install packer
packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -d $packer_dir ]; then
    echo ">>> Pulling the lateset packer ..."
    cd $packer_dir
    git pull --depth 1
else
    echo ">>> Cloneing packer source code ..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
fi

# Relocate to the project root
cd $(git rev-parse --show-toplevel)
stow nvim
nvim --headless +PackerInstall +q
