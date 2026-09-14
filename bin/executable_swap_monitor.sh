#!/bin/bash -e

# Swaps between internal and external displays
# Now, on wayland with sway and dotfiles managed with chezmoi

INTERNAL_DISPLAY="eDP-1"
EXTERNAL_DISPLAY="DP-1"

error() {
  >&2 echo "$1"
  exit 1
}


for dependency in gawk swaymsg chezmoi; do
  hash "$dependency" 2>/dev/null || error "$0 depends on $dependency"
done

CURRENT=$(gawk 'match($0, /colors.*"(eink|default|wal)"/, a) {print a[1]}' ~/.config/chezmoi/chezmoi.toml)

set_chezmoi_config() {
  sed -i "s/= \"$CURRENT/= \"$1/g" ~/.config/chezmoi/chezmoi.toml
}

toggle_chezmoi_config() {
  local new="eink"
  case "$CURRENT" in
    eink)
      new="default"
      ;;
    *)
      new="eink"
      ;;
  esac
  set_chezmoi_config "$new"
}

tolaptop() {
  set_chezmoi_config "default"
  chezmoi apply
  swaymsg reload && sleep 1
  swaymsg "output \"$EXTERNAL_DISPLAY\" disable ; output \"$INTERNAL_DISPLAY\" enable"
}

tomonitor() {
  set_chezmoi_config "eink"
  chezmoi apply
  swaymsg reload && sleep 1
  swaymsg "output \"$INTERNAL_DISPLAY\" disable ; output \"$EXTERNAL_DISPLAY\" enable"
}

toggle() {
  if [ $(swaymsg -t get_outputs | jq -r '.[]|select(.active)|.name' | wc -l) -gt 1 ]; then
    error "both outputs are active, refusing to swap"
  fi
  toggle_chezmoi_config
  chezmoi apply
  local currentoutput=$(swaymsg -t get_outputs | jq -r '.[]|select(.active)|.name')
  case "$currentoutput" in
    "$INTERNAL_DISPLAY")
      echo "internal is current"
      swaymsg reload && sleep 1
      swaymsg "output \"$INTERNAL_DISPLAY\" disable ; output \"$EXTERNAL_DISPLAY\" enable"
      ;;
    "$EXTERNAL_DISPLAY")
      echo "external is current"
      swaymsg reload && sleep 1
      swaymsg "output \"$EXTERNAL_DISPLAY\" disable ; output \"$INTERNAL_DISPLAY\" enable"
      ;;
    *)
      toggle_chezmoi_config
      chezmoi apply
      error "Cannot parse which display is active, refusing to swap"
      ;;
  esac
}

if [[ $# -gt 0 ]]; then
  case "$1" in
    '-i'|'--internal')
      tolaptop
      ;;
    '-e'|'--external')
      tomonitor
      ;;
  esac
  exit 0
fi
toggle
