# ~/.xinitrc
############

# set x options and colors
##########################

xrdb -merge .Xresources
xset +fp /usr/share/fonts/local
xset fp rehash
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &

# program init
##############

#sudo asus-kbd-backlight allowusers &
#compton &
#sxhkd &
dunst &

# WM init
#########

#exec herbstluftwm
#exec openbox
#exec wmaker
exec i3
