# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
setxkbmap -option caps:escape &
#exec openbox-session
exec i3
#Fuck dat setxkbmap -option terminate:ctrl_alt_bksp &
#exec awesome
#exec dwm
#sh /usr/bin/startdwm.sh
