#!/bin/sh

set -e

#xset +fp /usr/share/fonts/TTF
#xset fp rehash

setxkbmap fr bepo
xrandr --output VGA-0 --mode 1920x1080
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
which VBoxClient-all && VBoxClient-all
which numlockx && numlockx &
which clipit && clipit &
which sxhkd && sxhkd -c ~/.sxhkdrc &
which dropbox && dropbox &

# Source: https://wiki.archlinux.org/index.php/Feh#As_a_desktop_wallpaper_manager
# Update with `feh --bg-center --randomize ~/Images/Wallpapers/*`
[ -f ~/.fehbg ] && ~/.fehbg

exec i3
