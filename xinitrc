# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
#systemd --user
asus-kbd-backlight allowusers

exec herbstluftwm
#exec wmaker

#sxhkd &
#exec bspwm

#wmswap & wmpid=$!
#wait $wmpid
