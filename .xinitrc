#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap pt

while :; do
  sound=$(amixer get Master | awk -F'[][]' 'END{ print $2 }')
  root=$(df -h / | awk 'END { print $4 }')
  home=$(df -h /home | awk 'END { print $4 }')
  wifi=$(cat /sys/class/net/wlo1/operstate)
  therm=$(sed 's/000$/ºC/' /sys/class/thermal/thermal_zone0/temp)
  bat=$(battery)
  date=$(date "+%d-%m-%y %H:%M:%S")
  xsetroot -name " $sound | / $root /home $home | $wifi | $therm | $bat | $date"
  sleep 1
done &

#
# start if not running:
#   mpd,
#   picom,
#   dunst,
#   redshift
#
! pgrep -x mpd >/dev/null && mpd >/dev/null 2>&1 &
! pgrep -x picom >/dev/null && picom >/dev/null 2>&1 &
! pgrep -x dunst >/dev/null && dunst >/dev/null 2>&1 &
! pgrep -x redshift >/dev/null & redshift >/dev/null 2>&1 &

# set wallpaper
feh --no-fehbg --bg-scale ~/.config/wall.* 2>&1 >/dev/null &

exec dwm
