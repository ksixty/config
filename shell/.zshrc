export HISTFILE=~/.zsh_history
export SAVEHIST=1000000000
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

source ~/.profile

# Allow for autocomplete to be case insensitive
#zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
#  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit
compinit -i

PS1="%1~ § "
# PS1=">: "

function xtitle () {
    builtin print -n -- "\e]0;$@\a"
}
function precmd () {
    # xtitle "$(print -P $USER@$HOST: '%~')"
}
function preexec () {
    # xtitle "$1 — $(print -P $USER@$HOST: '%~')"
}

alias yota='sudo sysctl net.ipv4.ip_default_ttl=65'
alias xkpasswd='hsxkpasswd -p xkcd'
eval "$(zoxide init zsh)"
