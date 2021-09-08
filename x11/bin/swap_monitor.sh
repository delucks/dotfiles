#!/bin/bash -e

# Swaps between the internal and external monitors.
# My external monitor is a 4K display which should use scaled DPI, so this script also modifies ~/.Xresources

# A previous version set a custom modeline for the new monitor, here is the procedure should I need it again:
#RESOLUTION="2560 1080 44"
#MODELINE=$(cvt $RESOLUTION | cut -f2 -d$'\n')
#MODEDATA=$(echo "$MODELINE" | cut -f 3- -d' ')
#MODENAME=$(echo "$MODELINE" | cut -f2 -d' ')
#if ! xrandr --current | grep -q "$MODENAME"; then
#  # External monitor doesn't have the correct resolution in this X session yet: create it
#  echo "Adding mode - $MODENAME $MODEDATA"
#  xrandr --newmode "$MODENAME" $MODEDATA
#  xrandr --addmode "$EXTERNAL_DISPLAY" "$MODENAME"
#fi
#xrandr --output "$EXTERNAL_DISPLAY" --primary --mode "$MODENAME" --pos 0x0 --rotate normal --output "$INTERNAL_DISPLAY" --off

INTERNAL_DISPLAY="eDP1"
EXTERNAL_DISPLAY="HDMI2"

lowdpi() {
  sed -i 's/^Xft.dpi: 192/Xft.dpi: 96/g' "$HOME/.Xresources"
  xrdb "$HOME/.Xresources"
}

hidpi() {
  sed -i 's/^Xft.dpi: 96/Xft.dpi: 192/g' "$HOME/.Xresources"
  xrdb "$HOME/.Xresources"
}

swap_to_internal() {
  lowdpi
  xrandr --output "$EXTERNAL_DISPLAY" --off --output "$INTERNAL_DISPLAY" --auto
  i3-msg restart
}

swap_to_external() {
  hidpi
  xrandr --output "$EXTERNAL_DISPLAY" --primary --mode 3840x2160 --pos 0x0 --rotate normal --output "$INTERNAL_DISPLAY" --off
  i3-msg restart
}

right_of_external() {
  hidpi
  xrandr --output "$INTERNAL_DISPLAY" --mode 1920x1080 --pos 3840x1080 --rotate normal --output "$EXTERNAL_DISPLAY" --primary --mode 3840x2160 --pos 0x0 --rotate normal
}

if [[ $# -gt 0 ]]; then
  case "$1" in
    '-i'|'--internal')
      swap_to_internal
      ;;
    '-e'|'--external')
      swap_to_external
      ;;
    '-r'|'--right')
      right_of_external
      ;;
  esac
  exit 0
fi
