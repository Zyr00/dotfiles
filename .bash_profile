#!/bin/sh
#
# Runs on login
#

export EDITOR="vim"
export READER="zathura"
export BROWSER="firefox"

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
