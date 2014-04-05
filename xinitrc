# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
sudo asus-kbd-backlight allowusers &
compton &

exec herbstluftwm
#exec subtle

#exec gnome-session
#exec openbox
#exec wmaker
#sxhkd &
#exec bspwm
