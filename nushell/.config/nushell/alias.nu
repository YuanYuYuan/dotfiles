module ls_mod {
    export def ls_func [] {
        ls | sort-by type name -i | grid -c
    }
    export alias l = ls_func
    export alias ll = ls --all
}
use ls_mod *

def --env ranger_with_cd [] {
    let last_dir = $"($env.HOME)/.cache/rangerdir"
    ranger --choosedir $last_dir
    cd (cat $last_dir)
}

def --env cd_mkdir [p: string] {
    if not ($p | path exists) {
        mkdir ($p | path expand)
    }
    cd $p
}

def open_in_neovide [path: string] {
    let pipe = $'($env.HOME)/.cache/nvim/server.pipe'
    if not ($pipe | path exists) {
        neovide -- --listen $pipe

        # dashboard can take some time to start
        sleep 1sec

        while not ($pipe | path exists) {
            sleep 0.1sec
            echo "Waiting for pipe established"
        }
    }
    if ($path | str contains ":") {
        let data = $path | split column ":" | rename file_path line_number | into record
        let file_path = realpath $data.file_path
        nvim --server $pipe --remote-send $":e ($file_path) | ($data.line_number) <CR>zz"
    } else {
        nvim --server $pipe --remote $path
    }
}

def copy_real_path [file_path: string] {
    realpath $file_path | wl-copy -n
}

alias cdm = cd_mkdir
alias nv = open_in_neovide
alias p = python
alias rng = ranger_with_cd
alias s = sdcv
alias tm = tmux attach
alias v = nvim
alias z = zoxide
alias g = git status .
alias wrp = copy_real_path
alias wp = wl-paste -n

# alias nv = $'($HOME)/.config/nvim/scripts/open-in-neovide.sh'
# alias rng = $'ranger --choosedir=($HOME)/.rangerdir; LASTDIR=`cat ($HOME)/.rangerdir`; cd "($LASTDIR)"'
