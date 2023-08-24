#HISTFILE=$HOME/.history
#HISTSIZE=100000

if [ -z "$PWD" ]; then
    PWD=$HOME
    export PWD
fi

export EDITOR="emacsclient -nc"
export VISUAL="$EDITOR"
set -o emacs
alias e="$EDITOR"

#export ENV=$HOME/.kshrc
export PATH
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export MOZ_ENABLE_WAYLAND=1

export DATE=`date +%F`

PATH="$PATH:/home/k60/.roswell/bin/"
PATH="$PATH:/home/k60/.cargo/bin/"
PATH="$PATH:/home/k60/.local/lib/python3.10"
PATH="$PATH:/home/k60/.local/bin/"


alias emc="$EDITOR"
alias sys="systemctl"
alias sus="systemctl --user"

source /etc/profile.d/emscripten.sh
