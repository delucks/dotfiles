# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xset +fp /usr/share/fonts/local
xset fp rehash
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
#sudo asus-kbd-backlight allowusers &
compton &

exec herbstluftwm
#exec i3
#exec openbox

#exec subtle
#exec gnome-session
#exec wmaker
#sxhkd &
#exec bspwm
