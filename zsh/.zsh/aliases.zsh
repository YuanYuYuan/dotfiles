# { Common } {{{
    # alias v='vim --servername vim'
    alias adoc='$HOME/Workings/scripts/asciidoc-autoreload.sh'
    alias ez='exec zsh'
    alias g='googler -n 5'
    alias h='history -i'
    alias lv='nvim -u $HOME/.config/nvim/init-lua-plugin.vim'
    alias m='make'
    alias mutt='neomutt'
    alias o='gio open'
    alias pac='pacman'
    alias rng='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
    alias s='sdcv'
    alias speak='trans -speak -b'
    alias sync-mail='$HOME/Workings/scripts/notify-new-mail.sh&; offlineimap'
    alias tm='tmux attach-session || tmux'
    alias uv='urlview'
    alias v='nvim'
# }}}

# { Python } {{{
    alias p='python'
    alias p2='python2'
    alias ipy='ipython'
# }}}

# { Xclip } {{{
    alias x='xclip -se c -r'
    alias cx='cd $(x -o)'
    alias wx='wget --continue --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64)\
        AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" $(x -o)'
    alias gdx='gdrive download -r $(x -o | cut -d = -f 2)'
    alias gx='git clone $(x -o)'
# }}}

# { Configuration } {{{
    alias cfg-zsh='$EDITOR ~/.zshrc'
    alias cfg-i3='$EDITOR ~/.config/i3/config'
    alias cfg-tmux='$EDITOR ~/.config/tmux/tmux.conf'
    alias cfg-vim='$EDITOR ~/.vimrc ~/.vim/plugins.vim'
    alias cfg-mutt='$EDITOR ~/.config/mutt/muttrc'
    alias cfg-ssh='$EDITOR ~/.ssh/config'
    alias cfg-alias='$EDITOR ~/.aliases'
    alias cfg-ranger='$EDITOR ~/.config/ranger/rc.conf'
# }}}

# { Youtube } {{{
    alias yt-music='youtube-dl --config-location $HOME/.config/youtube-dl/music.conf'
    alias yt-musicpl='youtube-dl --config-location $HOME/.config/youtube-dl/music-playlist.conf'
    alias yt-video='youtube-dl --config-location $HOME/.config/youtube-dl/video.conf'
    alias yt-videopl='youtube-dl --config-location $HOME/.config/youtube-dl/video-playlist.conf'
    alias sync-yt='$HOME/Workings/scripts/sync-youtube-playlist.sh'
    alias ytx='youtube-dl --config-location $HOME/.config/youtube-dl/video.conf $(xclip -se c -r -o)'
# }}}

# { Navigation } {{{
    alias '..'='cd ../'
    alias '...'=../..
    alias '....'=../../..
    alias '.....'=../../../..
    alias '......'=../../../../..
    alias 1='cd -'
    alias 2='cd -2'
    alias 3='cd -3'
    alias 4='cd -4'
    alias 5='cd -5'
    alias 6='cd -6'
    alias 7='cd -7'
    alias 8='cd -8'
    alias 9='cd -9'
# }}}

# { dirs } {{{
    alias d='dirs -v | head -10'
    alias po=popd
    alias pu=pushd
# }}}

# { list } {{{
    alias l='ls -lah'
    alias la='ls -lAh'
    alias ll='ls -lh'
    alias lt='ls -rlath'
    alias ls='ls --color=tty'
    alias lsa='ls -lah'
# }}}

# { sk } {{{
    alias xk='realpath $(sk) | xclip -selection clipboard -in -rmlastnl'
    alias osk='xdg-open "$(sk)"'
    alias rsk='sk --ansi -i -c "rg --color=always --line-number "{}""'
# }}}

# { Git } {{{
    alias gst='git status'
# }}}

# vim:filetype=zsh
