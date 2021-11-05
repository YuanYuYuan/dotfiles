# { System Variables } {{{

    # { System } {{{
        export XDG_CONFIG_HOME="$HOME/.config"
        export BROWSER="/usr/bin/firefox"
        export EDITOR="/usr/bin/nvim"
        export TERMINAL='/usr/bin/alacritty'
        export VISUAL="nvim"
    # }}}

    # { Rust } {{{
        source "$HOME/.cargo/env"
        export RUST_LOG=info
        # SCCACHE_IDLE_TIMEOUT=0 sccache --start-server &> /dev/null
    # }}}

    # { Ruby } {{{
        export GEM_HOME=$(ruby -e 'print Gem.user_dir')
        export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
    # }}}

    # { Golang } {{{
        export GOPATH=$HOME/go
        export PATH="$PATH:$GOPATH/bin"
    # }}}

    # { NPM } {{{
        export PATH="$HOME/.node_modules/bin:$PATH"
        export npm_config_prefix="$HOME/.node_modules"
    # }}}

    # { PATH } {{{
        export PATH="$PATH:$HOME/.local/bin"
        export PATH="$PATH:$HOME/Workings/scripts"
        export PATH="/usr/lib/ccache/bin/:$PATH"
    # }}}

    # { Torch / CUDA for Arch } {{{
        export LIBTORCH=/usr

        # CUDA
        export CPATH="$CPATH:/opt/cuda/include"
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64"
        export LIBRARY_PATH="$LIBRARY_PATH:/opt/cuda/lib64"
        export CUDA_HOME="/opt/cuda"
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

# }}}
