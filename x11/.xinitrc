# ~/.xinitrc
############

# set x options and colors
##########################

xrdb ~/.Xresources
xset +fp /usr/share/fonts/local
xset fp rehash
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
xsetroot -bg "#8b3e2f" -mod 3 3
xset s off
xset s noblank

exec i3
