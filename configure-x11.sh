#!/usr/bin/env bash

# sets up the few variables needed for the dynamic x11 setup to work.
USER=$(whoami)
DEFAULT_SCHEME=x11/.config/colors/zbrah.colors
I3_CONFIG=x11/.i3/config
I3_TEMPLATE=x11/.i3/config-template
XRESOURCES=x11/.Xresources
XRESOURCES_TEMPLATE=x11/.Xresources-template

source x11/bin/common.sh
x11::parsecolors "${DEFAULT_SCHEME}"

x11::templatei3() {
  if [ -f $I3_CONFIG ]; then
    echo "Cannot clobber existing template"
    return 1
  fi
  for i in $(seq 0 17); do
    varname=color$i
    echo "set \$color$i ${!varname}"
  done | tee $I3_CONFIG
  echo | tee -a $I3_CONFIG
  cat $I3_TEMPLATE | tee -a $I3_CONFIG
  echo
  echo "i3 successfully templated"
  echo
}

x11::templateXresources() {
  if [ -f $XRESOURCES ]; then
    echo "Cannot clobber existing template"
    return 1
  fi
  echo "#include \"/home/$USER/.colors\"" | tee $XRESOURCES
  cat $XRESOURCES_TEMPLATE | tee -a $XRESOURCES
  echo
  echo ".Xresources successfully templated"
  echo
}

x11::templatei3
x11::templateXresources
