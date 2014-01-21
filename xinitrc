# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
systemd --user

exec herbstluftwm
#exec openbox
#sxhkd &
#exec bspwm

#wmswap & wmpid=$!
#wait $wmpid
