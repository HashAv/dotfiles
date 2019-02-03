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

# /etc/pam.d/login
# Add those 2 lines below  pam_group.so
# auth      optional     pam_gnome_keyring.so
# session   optional     pam_gnome_keyring.so auto_start

# --replace does not work, as it kills the daemon on i3 exit
# --start seems to allow the creation of another daemon, that communicates with the one launched with pamd
# At this stage, I should have this envvar loaded GNOME_KEYRING_CONTROL=~/.cache/keyring-ABCDEF
eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets,ssh,gpg)
# At this stage, SSH_AUTH_SOCK should look like ~/.cache/keyring-ABCDEF/ssh
# If SSH_AUTH_SOCK looks like /run/user/1000/keyring/ssh, something failed
export SSH_AUTH_SOCK

xrdb -merge ~/.Xresources

exec i3
