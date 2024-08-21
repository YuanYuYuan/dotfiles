module ls_mod {
    export def ls_func [] {
        ls | sort-by type name -i | grid -c
    }
    export alias l = ls_func
    export alias ll = ls --all
}
use ls_mod *

def --env cdm [p: string] {
    if not ($p | path exists) {
        mkdir ($p | path expand)
    }
    cd $p
}

def --env yy [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

def open_in_neovide [path: string] {
    let pipe = $'($env.HOME)/.cache/nvim/server.pipe'
    if not ($pipe | path exists) {
        neovide --fork -- --listen $pipe

        # dashboard can take some time to start
        sleep 1sec

        while not ($pipe | path exists) {
            sleep 0.1sec
            print "Waiting for pipe established"
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

# copy the real path of the given file
def wrp [file_path: string] {
    realpath $file_path | wl-copy -n
}

alias nv = open_in_neovide
alias p = python
alias s = sdcv
alias tm = tmux attach
alias v = nvim
alias z = zoxide
alias g = git status .
alias o = xdg-open
alias wp = wl-paste -n
