PS1="\033]7;file://$PWD\a\t \h § "
#echo -ne "\033]7;file://$PWD\007" # notify the terminal about path
eval "$(pyenv init -)"
eval $(ssh-agent) > /dev/null
. $HOME/Scripts/wttr.sh
