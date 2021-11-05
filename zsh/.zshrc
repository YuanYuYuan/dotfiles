# { ZIM } {{{
    export ZIM_HOME="$HOME/.zim"

    # Automatically setup ZIM
    if [ ! -d $ZIM_HOME ]; then
        mkdir -p $ZIM_HOME
    fi
    if [ ! -f ${ZIM_HOME}/zimfw.zsh ]; then
        wget https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh -O ${ZIM_HOME}/zimfw.zsh
        zsh ${ZIM_HOME}/zimfw.zsh install
        exec zsh
    fi

    # Set editor default keymap to emacs (`-e`) or vi (`-v`)
    bindkey -e

    # { Spelling } {{{
        # Prompt for spelling correction of commands.
        #setopt CORRECT

        # Customize spelling correction prompt.
        #SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
    # }}}

    # Remove path separator from WORDCHARS.
    WORDCHARS=${WORDCHARS//[\/]}

    # { Highlight } {{{
        # Customize the style that the suggestions are shown with.
        # See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
        #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

        # Set what highlighters will be used.
        # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

        # Customize the main highlighter styles.
        # See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
        #typeset -A ZSH_HIGHLIGHT_STYLES
        #ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
    # }}}

    # { Initialize modules } {{{
        if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
          # Update static initialization script if it does not exist or it's outdated, before sourcing it
          source ${ZIM_HOME}/zimfw.zsh init -q
        fi
        source ${ZIM_HOME}/init.zsh
    # }}}

    # { zsh-history-substring-search } {{{
        # Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down

        # Bind up and down keys
        zmodload -F zsh/terminfo +p:terminfo
        if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
            bindkey ${terminfo[kcuu1]} history-substring-search-up
            bindkey ${terminfo[kcud1]} history-substring-search-down
        fi

        bindkey '^P' history-substring-search-up
        bindkey '^N' history-substring-search-down
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
        # }}}

# }}}

# { Prompt: Starship } {{{
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
# }}}

# { ZSH Config } {{{
    export ZSH_HOME="$HOME/.zsh"
    source "${ZSH_HOME}/aliases.zsh"
    source "${ZSH_HOME}/functions.zsh"
    source "${ZSH_HOME}/env.zsh"
# }}}

# { Environment Variables } {{{

    # { History } {{{
        # Remove older command from the history if a duplicate is to be added.
        setopt HIST_IGNORE_ALL_DUPS
        export HISTFILE="$HOME/.zsh_history"
        export HIST_STAMPS="mm/dd/yyyy"
        export HISTSIZE=999999999
        export SAVEHIST=999999999
    # }}}

    # { Terminal } {{{
        # export TERM=xterm-256color
        if [[ "$TERM" =~ "xterm" ]]; then
            export TERM=xterm-256color
        elif [ "$TERM" = "screen" -o "$TERM" = "screen-256color" ]; then
            export TERM=screen-256color
            unset TERMCAP
        fi
    # }}}

# }}}

# { Configs } {{{
    # disable Software Flow Control (XON/XOFF flow control)
    stty -ixon

    # completion
    autoload -U compinit && compinit

    # enable completion after =
    setopt magicequalsubst

    # Starting X11 on console login
    if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then
        # exec startx
    fi
# }}}
