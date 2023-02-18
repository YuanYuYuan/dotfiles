# { System Variables } {{{

    # { System } {{{
        export XDG_CONFIG_HOME="$HOME/.config"
        export BROWSER="/usr/bin/firefox"
        export EDITOR="/usr/bin/nvim"
        export TERMINAL='/usr/bin/alacritty'
        export VISUAL="nvim"
        export STARDICT_DATA_DIR=$XDG_CONFIG_HOME/stardict
        export UE4_ROOT=~/UnrealEngine_4.26

        # /usr/local/lib
        export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

        # $HOME/.local
        export CPATH="$HOME/.local/include:$CPATH"
        export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
    # }}}

    # { Rust } {{{
        [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
        export RUST_LOG=info
        # SCCACHE_IDLE_TIMEOUT=0 sccache --start-server &> /dev/null
    # }}}

    # { Ruby } {{{
        command -v ruby &> /dev/null && {
            export GEM_HOME=$(ruby -e 'print Gem.user_dir')
            export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
        }
    # }}}

    # { Golang } {{{
        command -v go &> /dev/null && {
            export GOPATH=$HOME/go
            export PATH="$GOPATH/bin:$PATH"
        }
    # }}}

    # { NPM } {{{
        command -v npm &> /dev/null && {
            export PATH="$HOME/.node_modules/bin:$PATH"
            export npm_config_prefix="$HOME/.node_modules"
        }
    # }}}

    # { PATH } {{{
        export PATH="$HOME/.local/bin:$PATH"
        export PATH="$HOME/Workings/scripts:$PATH"
        export PATH="/usr/lib/ccache/bin/:$PATH"
    # }}}

    # { Torch / CUDA for Arch } {{{
        export LIBTORCH=/usr

        # CUDA
        export CPATH="/opt/cuda/include:$CPATH"
        export LD_LIBRARY_PATH="/opt/cuda/lib64:$LD_LIBRARY_PATH"
        # export LIBRARY_PATH="/opt/cuda/lib64:$LIBRARY_PATH"
        # export CUDA_HOME="/opt/cuda"
    # }}}

    # # { Torch / CUDA for Ubuntu } {{{
    #     # PyTorch
    #     PY_VER=3.8
    #     export LIBTORCH="/usr/local/lib/python${PY_VER}/dist-packages/torch"
    #     export LD_LIBRARY_PATH="/usr/local/lib/python${PY_VER}/dist-packages/torch/lib:$LD_LIBRARY_PATH"

    #     # CUDA
    #     CUDA_VER=11.3
    #     export PATH="/usr/local/cuda-${CUDA_VER}/bin:$PATH"
    #     export LD_LIBRARY_PATH="/usr/local/cuda-${CUDA_VER}/lib64:$LD_LIBRARY_PATH"
    #     export LIBRARY_PATH="/usr/local/cuda-${CUDA_VER}/lib64:$LIBRARY_PATH"
    # # }}}

    # { Poetry } {{{
        # https://github.com/python-poetry/poetry/issues/5250#issuecomment-1067193647
        export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring
    # }}}

# }}}
