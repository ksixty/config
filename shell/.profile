HISTFILE=$HOME/.history
HISTSIZE=100000

if [ -z "$PWD" ]; then
    PWD=$HOME
    export PWD
fi

export EDITOR="emacsclient"
export VISUAL="$EDITOR"
set -o emacs

PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="/Applications/mpv.app/Contents/MacOS:$PATH"
PATH="/opt/mybin:$PATH"
PATH="/usr/sbin:$PATH"

PYENV_ROOT="$HOME/.pyenv"
export PYENV_ROOT

PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export ENV=$HOME/.kshrc
. /Users/admin/.nix-profile/etc/profile.d/nix.sh

export PATH
if [ -e /Users/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PASSWORD_STORE_ENABLE_EXTENSIONS=true
