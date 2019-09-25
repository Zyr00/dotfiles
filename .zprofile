#!/bin/sh
#
# Runs on login
#

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

# Auto start
xset s 180
xss-lock -- i3lockrc ~/.config/lock.* && systemctl suspend

mpd >/dev/null 2>&1 &

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

