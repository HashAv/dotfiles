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

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

xset +fp /usr/share/fonts/local
xset fp rehash

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

setxkbmap fr bepo
# exec xterm -geometry 1920x1080
#exec awesome

# May not be needed after all
#[[ -f ~/.profile ]] && source ~/.profile
exec startkde
