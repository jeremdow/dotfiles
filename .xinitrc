#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset r rate 240 24
urxvtd -q -f -o
unclutter -grab -root &
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dwm
