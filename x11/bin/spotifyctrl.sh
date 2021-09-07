#!/usr/bin/env bash
# This accompanies the "spotify" tmux session which launches the "spt" Spotify browser
# We use the naming convention of that session to send keypresses to the "spt" client, controlling the spotifyd daemon

case "$1" in
  toggle)
    tmux send-keys -t '=spotify:=spt' 'Space'
    ;;
  stop)
    systemctl --user stop spotifyd
    ;;
  prev)
    tmux send-keys -t '=spotify:=spt' 'p'
    ;;
  next)
    tmux send-keys -t '=spotify:=spt' 'n'
    ;;
  *)
    echo "Incorrect arg $1 passed to $0. Try one of {toggle,stop,prev,next}"
    exit 1
esac
