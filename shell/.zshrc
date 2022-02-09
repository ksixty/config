source ~/.profile
#eval "$(pyenv init -)"
#if [ -e /Users/admin/.nix-profile/etc/profile.d/nix.sh ]; then . #/Users/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit
compinit -i

PS1="%n@%m %1~ § "
