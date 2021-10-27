# vim:filetype=sh

exists() { which $1 &> /dev/null }

td() { termdown $1 && notify-send "Time's up!!!" && mpv ~/Music/apple_ring.mp3 --no-resume-playback }

xrp() { realpath $1 | xclip -selection clipboard -in -rmlastnl }

# xp() { xclip -selection clipboard -out -target image/png > ${1}.png }
xp() { cp /tmp/screenshot.png ${1}.png }

xc() { cat $1 | xclip -selection clipboard -in -rmlastnl }

vman() { /usr/bin/man $@ | col -b | /usr/bin/vim -R -c 'set nu! ft=man nomod nolist' - }

tbd() { pkill tensorboard; tensorboard --logdir $1 > /dev/null 2>&1 & $BROWSER http://localhost:6006}

function rnpdf {
    pdftotext $1 -f 1 /tmp/tmp.txt; cat /tmp/tmp.txt | head -n 20 | $EDITOR -;
    mv -v $1 "$(xclip -se c -r -o)".pdf;
}


# take functions

# mkcd is equivalent to takedir
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

function takeurl() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -1)"
  rm "$data"
  cd "$thedir"
}

function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

function take() {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}
