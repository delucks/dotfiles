# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
#exec openbox-session
#exec i3
exec herbstluftwm
#Fuck dat setxkbmap -option terminate:ctrl_alt_bksp &
#exec awesome
#exec dwm
#sh /usr/bin/startdwm.sh
