# Neovim

## Install neovim

### Option 1. Install with package manager

Directly install it from your system package manager.
Note that this depends on your operating system and require the administrator privilege.

### Option 2. Build from source

1. Build the neovim, the default version is nightly (0.7.0).

```
./install.sh
```

2. The default executable path is `$HOME/.local/bin/nvim`, so you may add the following line to your bashrc.

```
export PATH="$HOME/.local/bin:$PATH"
```

## Post-installation

1. Launch neovim and install the plugins

    ```vim
    :PackerSync
    :PackerCompile
    ```
