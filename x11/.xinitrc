# ~/.xinitrc
############

# set x options and colors
##########################

xrdb .Xresources
xset +fp /usr/share/fonts/local
xset fp rehash
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
xsetroot -bg "#8b3e2f" -mod 3 3

# program init
##############

#sudo asus-kbd-backlight allowusers &
#compton &
#sxhkd &
#dunst &

# WM init
#########

#exec herbstluftwm
#exec openbox
#exec wmaker
exec i3
