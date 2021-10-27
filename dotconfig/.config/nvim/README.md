# Neovim

## Install neovim

### Option 1. Install with package manager

Directly install it from your system package manager.
Note that this depends on your operating system and require the administrator privilege.

### Option 2. Build from source

1. Clone the source code.
    ```bash
    git clone https://github.com/neovim/neovim
    ```
2. Make sure your environment satisfies the
[build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites).

3. Build locally

    ```bash
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
    ```
4. Add support for python

    ```bash
    pip3 install neovim
    pip2 install neovim
    ```

5. Use neovim

    ```bash
    export PATH=$HOME/neovim/bin:$PATH
    nvim
    ```
    One may add the `PATH` variable permanently in shell environment(e.g. bash) by

    ```bash
    echo "export PATH=$HOME/neovim/bin:$PATH" >> ~/.bashrc
    ```


## Initialization

1. After cloned this project, copy the files in this folder to _~/.config/nvim_.

2. Install vim-plug

    ```bash
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
3. Launch neovim and install the plugins

    ```vim
    :PlugInstall
    ```
