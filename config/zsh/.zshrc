# Enable colors and change prompt:
autoload -U colors && colors
PS1="[%n@%M %1~]$ "
# PS1="%(#~%B~)%{%(#~$fg[red]~$fg[green])%}[%n@%M %{$fg[white]%}%1~%{%(#~$fg[red]~$fg[green])%}]%(#~#~$)%{$reset_color%}%b "
# PS1="%(#~%B~)%{%(#~$fg[red]~$fg[blue])%}[%n@%M %{$fg[white]%}%1~%{%(#~$fg[red]~$fg[blue])%}]%(#~#~$)%{$reset_color%}%b "

# Enable auto cd
setopt autocd

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey -s '^a' 'fg\n'

n ()
{
  #  Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  nnn -d -e "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" >/dev/null
  fi
}

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
