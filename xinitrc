#!/bin/sh

#xset +fp /usr/share/fonts/local
#xset fp rehash

setxkbmap fr bepo
xrandr --output VGA-0 --mode 1920x1080
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
which VBoxClient-all && VBoxClient-all
exec i3
