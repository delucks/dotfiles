# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
sudo asus-kbd-backlight allowusers &
compton &

#exec gnome-session
exec herbstluftwm
#exec wmaker

#sxhkd &
#exec bspwm

#wmswap & wmpid=$!
#wait $wmpid
