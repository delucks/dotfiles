#!/usr/bin/env bash

# common functions for use across my x11 scripts

x11::parsecolors() {
  # reads an x11 config formatted file and exports variables based on its content
  SOURCE_FILE="${1:-$HOME/.colors}"
  test -f $SOURCE_FILE || echo "$SOURCE_FILE must exist!"
  while read line; do
    eval $(echo $line | tr -d '*:' | awk '{print "export "$1"=\""$2"\""}')
  done < $SOURCE_FILE
}

x11::assigndmenu() {
  x11::parsecolors
  DMENU="dmenu -i -nb $color0 -nf $color10 -sb $color0 -sf $color2"
  DMENUR="dmenu_run -i -nb $color0 -nf $color10 -sb $color0 -sf $color1"
  MDMENU="dmenu -o 0.8 -i -l 25 -x 0 -y 0 -w 1920 -h 0 -nb $color0 -nf $COLOR10 -sb $color0 -sf $color1"
}

x11::displaycolors() {
  for i in $(seq 0 13); do
    varname=color$i
    echo "\$color$i: ${!varname}"
  done
}
