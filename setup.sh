#!/usr/bin/env bash

# This program uses whiptail to provide a graphical setup for my dotfiles
# Why? no raisin

if [[ "$(uname)" -ne "Linux" ]];
then
  echo "This script is localized to Linux"
  exit 1
fi

cols=$(tput cols)
rows=$(tput lines)
width=$(($rows / 2))
height=$(($cols - 10))

targets=$(egrep '^[a-z\-]+:' Makefile | sed 's/:.*//g')
descriptions=("all" "remove-all" "dev-install" "dev-remove" "env-install" "env-remove" "vim-install" "vim-remove" "media-install" "media-remove" "shell-install" "shell-remove" "xorg-install" "xorg-remove" "git-install" "git-remove" "misc-install" "misc-remove")
declare -a combined

for item in ${targets[@]}
do
  position=${#combined[@]}
  combined[$position]="$item"
  next=$(($position + 1))
  foo=descriptions[$position]
  combined[$next]="$foo"
done

whiptail --menu "delucks/dotfiles Install Script: Select Target" $width $height 10 $combined
