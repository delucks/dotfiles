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

#export PANEL_FIFO=/home/lumo/.tmp/bspwm-fifo
#[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
#mkfifo "$PANEL_FIFO"
#exec bspwm -s "$PANEL_FIFO" -p W -c /home/jamie/.config/bspwm/bspwmrc 

wmswap & wmpid=$!
wait $wmpid
