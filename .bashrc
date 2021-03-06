# --- personal ---
PROMPT_DIRTRIM=3
PS1='\[\033[01;34m\]$(shortenedPWD)\[\033[00m\] \$ '
shortenedPWD() {
  maxSlashes=3
  slashCount=$(($(dirs +0 | sed 's/[^\/]//g' | wc -c)-1))
  if [ $slashCount -gt $maxSlashes ]
  then
    prefix=$([[ $(pwd) == $HOME* ]] && echo "~" || echo "/")
    dirs=($(echo $(dirs +0 | tr "/" "\n")))
    shortenedPath=$(joinBy "/" ${dirs[@]: -$maxSlashes})
    echo $prefix$shortenedPath
  else
    echo $(dirs +0)
  fi
}

function joinBy { local IFS="$1"; shift; echo "$*"; }

alias ty='sudo -E env "PATH=$PATH"'

export PATH="$HOME/chromiumos/chromite/bin:$PATH"

# useful env vars
export CR=~/chromium
export CROS=~/cros
# set vim mode in bash
set -o vi

# NodeJS
export NODEJS_HOME=/opt/node-v10.1.0-linux-x64/bin
export PATH=$NODEJS_HOME:$PATH

export PATH=$HOME/depot_tools:$PATH

# Go
export GOPATH=$HOME/go:${CROS}/src/platform/tast-tests:${CROS}/src/platform/tast:${CROS}/chroot/usr/lib/gopath:$HOME/uhid-tests

# Tast
export CGO_ENABLED=0

alias vim='nvim'
alias tmux='env TERM=xterm-256color tmux -f ~/config-files/.tmux.conf'

# Recording
# Recall that for ffmpeg you must run pavucontrol and set the correct audio
# This only needs to be done once, it should recall your preference next
# time you run it.
alias recvs='ffmpeg -y -f x11grab -s 1920x1080 -i :0.0 -f alsa -i default out.mkv'

export PATH="$PATH:$HOME/.local/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# helpful commands for working with chrome/chrome os
# set ip address environment variable
ipa() { export IPA=$1; }
# set board environment variable
board() { export BOARD=$1; }
# start chrome chroot
ccr() { cros chrome-sdk --board=${BOARD} --log-level=info; }
# build chrome
bcr() { autoninja -C ~/chromium/src/out_${BOARD}/Release chrome nacl_helper; }
# update chrome via ssh
crssh() { deploy_chrome --build-dir=~/chromium/src/out_${BOARD}/Release --to=${IPA}; }
# build and ssh to device
alias crbsh='bcr && crssh'
# push changes to chrome repo
alias crp='git push origin HEAD:refs/for/master'
# start chrome os chroot
alias ccros='cros_sdk'
# set up build for a given board
crosb() { setup_board --board=${BOARD}; }
# build packages for a given board
pacros() { ~/trunk/src/scripts/build_packages --board=${BOARD}; }
# build cros image
crosbi() { ~/trunk/src/scripts/build_image --board=${BOARD} --noenable_rootfs_verification test; }
# update image via ssh
crossh() { cros flash usb:// ${BOARD}/latest; }
croscomp() { FEATURES="noclean" cros_workon_make --board=${BOARD} --install chromeos-kernel-$1; }
# use xbuddy to update image via ssh
xbssh() { cros flash $IPA xbuddy://remote/$BOARD/latest/test; }
# flash xbuddy into a usb device
xbusb() { cros flash usb:// xbuddy://remote/$BOARD/latest/test; }

# miscelaneous
grep-all() { ls | xargs grep $1; }
findtext() { find -maxdepth $1 -type f | xargs grep $2; }
far() { find -type f | xargs sed -i "s/$1/$2/g"; }
seg() { cat $1 | head -n $(($2+10)) | tail -n 21; }
