#!/bin/sh

set -e

if test -z "$DBUS_SESSION_BUS_ADDRESS";then
  eval `dbus-launch --sh-syntax --exit-with-session`
  export DBUS_SESSION_BUS_ADDRESS
fi

setxkbmap fr bepo -option caps:swapescape

start-pulseaudio-x11

[ -f ~/.fehbg ] && ~/.fehbg

which dropbox && dropbox start

eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets,ssh,gpg)
export SSH_AUTH_SOCK

xrdb -merge ~/.Xresources

exec i3
