#!/bin/sh
#
# Runs on login
#

export PATH="$PATH:$HOME/.local/scripts"
export EDITOR="vim"
export READER="zathura"
export BROWSER="firefox"
export TERMINAL="st"

export NNN_USE_EDITOR=1

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
