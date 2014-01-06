# ~/.xinitrc, Executed by startx

xrdb -merge .Xresources
xmodmap ~/.Xmodmap
setxkbmap -option caps:escape &
systemd --user

exec herbstluftwm
#exec openbox

#wmswap & wmpid=$!
#wait $wmpid
