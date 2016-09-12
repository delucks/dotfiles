#!/usr/bin/env bash

# sets up the few variables needed for the dynamic x11 setup to work.
USER=$(whoami)
DEFAULT_SCHEME=x11/.config/colors/zbrah.colors
SCHEME_DEST=$HOME/.colors
# Other good fonts:
#-aaron-bitocra13-*-*-normal-*-13-*-*-*-*-*-*-*
#-*-gohufont-medium-r-*-*-14-*-*-*-*-*-iso10646-1
FONT='-*-tamsyn-medium-r-*-*-17-*-*-*-*-*-iso8859-*'

I3_CONFIG=x11/.i3/config
I3_TEMPLATE=x11/.i3/config-template

XRESOURCES=x11/.Xresources
XRESOURCES_TEMPLATE=x11/.Xresources-template

source x11/bin/common.sh
x11::parsecolors "${DEFAULT_SCHEME}"

x11::templatei3() {
  for i in $(seq 0 17); do
    varname=color$i
    echo "set \$color$i ${!varname}"
  done > "$I3_CONFIG"
  echo "font $FONT" >> "$I3_CONFIG"
  echo >> "$I3_CONFIG"
  cat "$I3_TEMPLATE" >> "$I3_CONFIG"
  echo
  echo "i3 successfully templated"
  echo
}

x11::templateXresources() {
  echo "#include \"/home/$USER/.colors\"" > "$XRESOURCES"
  echo "URxvt*background: $color16" >> "$XRESOURCES"
  echo "URxvt*foreground: $color17" >> "$XRESOURCES"
  echo "XTerm*background: $color16" >> "$XRESOURCES"
  echo "XTerm*foreground: $color17" >> "$XRESOURCES"
  echo "*font:	$FONT" >> "$XRESOURCES"
  echo "*boldFont:	$FONT" >> "$XRESOURCES"
  echo >> "$XRESOURCES"
  cat "$XRESOURCES_TEMPLATE" >> "$XRESOURCES"
  echo
  echo ".Xresources successfully templated"
  echo
  echo 'After you run $(stow x11), please symlink your desired colorscheme from ~/.config/colors/ to ~/.colors'
}

x11::templatei3
x11::templateXresources
