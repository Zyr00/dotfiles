#!/bin/sh

export PATH="$PATH:$HOME/.local/scripts/"
export EDITOR="vim"
export READER="zathura"
export BROWSER="firefox"
export TERMINAL="st"
export EMAIL="neomutt"
export FILE="nnn"
export PLAYER="ncmpcpp"

export ZDOTDIR="$HOME/.config/zsh"
export NNN_USE_EDITOR=1
export NNN_TMPFILE=1

# start dwm in tty1 if not running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >/dev/null && exec startx
