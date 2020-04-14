#!/bin/bash -e

# Swaps between the internal and external monitors

INTERNAL_DISPLAY="eDP-1"
EXTERNAL_DISPLAY="HDMI-1"
RESOLUTION="2560 1080 44"
MODELINE=$(cvt $RESOLUTION | cut -f2 -d$'\n')
MODEDATA=$(echo "$MODELINE" | cut -f 3- -d' ')
MODENAME=$(echo "$MODELINE" | cut -f2 -d' ')

swap_to_internal() {
  xrandr --output "$EXTERNAL_DISPLAY" --off --output "$INTERNAL_DISPLAY" --auto
}

swap_to_external() {
  if ! xrandr --current | grep -q "$MODENAME"; then
    # External monitor doesn't have the correct resolution in this X session yet: create it
    echo "Adding mode - $MODENAME $MODEDATA"
    xrandr --newmode "$MODENAME" $MODEDATA
    xrandr --addmode "$EXTERNAL_DISPLAY" "$MODENAME"
  fi
  xrandr --output "$EXTERNAL_DISPLAY" --primary --mode "$MODENAME" --pos 0x0 --rotate normal --output "$INTERNAL_DISPLAY" --off
}

if [[ $# -gt 0 ]]; then
  case "$1" in
    '-i'|'--internal')
      swap_to_internal
      ;;
    '-e'|'--external')
      swap_to_external
      ;;
  esac
  exit 0
fi

if xrandr --current | grep -q "$EXTERNAL_DISPLAY disconnected"; then
  echo "Swapping to internal display- $EXTERNAL_DISPLAY is disconnected"
  swap_to_internal
else
  echo "Swapping to external display"
  swap_to_external
fi
