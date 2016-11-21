#!/usr/bin/env bash

set -e
set -o pipefail
source x11/bin/common.sh

usage() {
  echo "Usage: $0 [-h, -i, -x, -a]"
  echo "  -h, --help: show help message"
  echo "  -i, --i3:   template the I3 config"
  echo "  -x, --x11:  template the X11 config"
  echo "  -a, --all:  template ALL the configs"
  echo
  echo "This script will use the following environment variables if they are set:"
  echo "  \$COLORSCHEME: the path to a x11 colorscheme definition parsed into i3 & terminals"
  echo "  \$X11_FONT:    a full x11 fontstring for use in both x11 and i3 (by default)"
  echo "  \$X11_FONT_I3: override the font definition used in i3"
  echo
  echo "Part of delucks' dotfiles: https://github.com/delucks/dotfiles"
}

x11::templatei3() {
  for i in $(seq 0 17); do
    varname=color$i
    echo "set \$color$i ${!varname}"
  done > "$I3_CONFIG"
  echo "font $I3_FONT" >> "$I3_CONFIG"
  echo >> "$I3_CONFIG"
  cat "$I3_TEMPLATE" >> "$I3_CONFIG"
  echo
  echo "i3 successfully templated"
  echo
}

x11::templateXresources() {
  echo "#include \"/home/$USER/.colors\"" > "$XRESOURCES"
  echo "urxvt*background: $color16" >> "$XRESOURCES"
  echo "urxvt*foreground: $color17" >> "$XRESOURCES"
  echo "xterm*background: $color16" >> "$XRESOURCES"
  echo "xterm*foreground: $color17" >> "$XRESOURCES"
  echo "urxvt*font:	$FONT" >> "$XRESOURCES"
  echo "urxvt*boldFont:	$FONT" >> "$XRESOURCES"
  echo >> "$XRESOURCES"
  cat "$XRESOURCES_TEMPLATE" >> "$XRESOURCES"
  echo
  echo ".Xresources successfully templated"
  echo
  echo 'After you run $(stow x11), please symlink your desired colorscheme from ~/.config/colors/ to ~/.colors'
  echo "I recommend $DEFAULT_SCHEME"
  echo "Merging the new resources..."
  xrdb -merge $HOME/.Xresources
}

# sets up the few variables needed for the dynamic x11 setup to work.
USER=$(whoami)
DEFAULT_SCHEME=x11/.config/colors/zbrah.colors
SCHEME_DEST=$HOME/.colors
SCHEME="${COLORSCHEME:-$DEFAULT_SCHEME}"
# Other good fonts:
#-aaron-bitocra13-*-*-normal-*-13-*-*-*-*-*-*-*
#-*-gohufont-medium-r-*-*-14-*-*-*-*-*-iso10646-1
#-*-tamsyn-medium-r-*-*-17-*-*-*-*-*-iso8859-*
#xft:Hack:pixelsize=14:antialias=true
#xft:Envy\ Code\ R:normal:pixelsize=14
#xft:inconsolata:pixelsize=14
FONT="${X11_FONT:--*-fixed-medium-r-normal-*-16-*-*-*-*-*-iso8859-*}"
I3_FONT="${X11_FONT_I3:-$FONT}"

I3_CONFIG=x11/.i3/config
I3_TEMPLATE=x11/.i3/config-template

XRESOURCES=x11/.Xresources
XRESOURCES_TEMPLATE=x11/.Xresources-template

x11::parsecolors "${DEFAULT_SCHEME}"

if test -z "$1"; then
  echo "$0 requires an argument!"
  echo
  usage
  exit 1
fi

while test ! -z "${1+x}"
do
  case "$1" in
    -a|--all)
      echo "Using font $FONT with the i3 font set to ${X11_FONT_I3:-the same}"
      x11::templatei3
      x11::templateXresources
    ;;
    -x|--x11)
      echo "Using font $FONT"
      x11::templateXresources
    ;;
    -i|--i3)
      echo "Using font $I3_FONT"
      x11::templatei3
    ;;
    -h|--help)
      usage && exit 1
    ;;
    *)
      echo "Unrecognized argument $1!"
      echo "For help, use -h"
      exit 1
  esac
  shift
done
