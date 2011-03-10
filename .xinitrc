#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xset r rate 240 24
urxvtd -q -f -o
numlockx
unclutter -root &
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec dbus-launch --exit-with-session ck-launch-session dwm
