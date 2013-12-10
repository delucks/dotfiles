# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
systemd --user

#exec i3
#exec herbstluftwm
#exec openbox
#exec gnome-session
#Fuck dat setxkbmap -option terminate:ctrl_alt_bksp &
#exec awesome

#~/scripts/lemonbar.sh &
wmswap & wmpid=$!
wait $wmpid
