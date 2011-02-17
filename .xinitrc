#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xset r rate 240 24
urxvtd -q -f -o
unclutter -grab -root &
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dwm
