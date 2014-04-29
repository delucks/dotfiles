#!/bin/bash

# File to add in all the necessary stuffs for my dotfiles
# Dat automation

# Author: delucks

set -e

function wallpapers {
	echo ":: Downloading wallpapers pack..."
	if [ $(which wget) ]; then
		wget -nc -c -O /tmp/wall.tar.gz http://www.jamesluck.com/raw/wall.tar.gz
	else
		curl http://www.jamesluck.com/raw/wall.tar.gz -o /tmp/wall.tar.gz
	fi
	echo ":: Extracting wallpapers pack to ~/dev/wp & ~/wallpapers..."
	cd
	tar xvf /tmp/wall.tar.gz
	echo ":: Done."
}

function linkOrMove {
	echo ":: Processing ~/dotfiles/$1 to ~/.$1"
	ln -s ~/dotfiles/$1 ~/.$1 > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		if [ -h ~/.$1 ]; then
			echo ":: WARNING :: A symlink already exists for $1. Check this manually."
			return 1
		else
			echo ":: ~/.$1 exists. Copying it to ~/.$1.bak"
			cp ~/.$1{,.bak}
			echo ":: Now removing the old ~/.$1"
			rm ~/.$1
			echo ":: Now linking ~/.$1"
			ln -s ~/dotfiles/$1 ~/.$1
			[ $? -eq 0 ] && echo ":: ~/.$1 linked successfully."
		fi
	else
		echo ":: ~/.$1 linked successfully."
	fi
	echo ""
}

function usage {
	echo "usage: setup.sh [option]"
	echo
	echo "Options:"
	echo "    -i, --incremental - Not yet implemented, don't use"
	echo "    -l, --headless    - Install everything not X-specific"
	echo "    -x, --xorg        - Install everything"
	echo "    -h, --help        - Show this help message"
	echo "    -v, --version     - Show a quick version summary"
	echo "    -w, --wallpaper   - Bootstrap my current wallpaper & colors"
	exit
}

function version {
	echo "setup.sh by delucks@github.com"
	echo
	echo "Contact:      jluck@udel.edu"
	echo "Version:      0.5a"
	echo
	echo "Thanks for using my dotfiles!"
	exit
}

homeDotfiles=("Xcolors" "Xmodmap" "Xresources" "abcde.conf" "bashrc" "compton.conf" "dmenurc" "i3" "i3status.conf" "irssi" "redshiftgrc" "tmux.conf" "vim" "vimrc" "xinitrc" "xmobarrc" "zshrc")

headlessHomeDotfiles=("bashrc" "irssi" "tmux.conf" "vim" "vimrc" "zshrc")

case "$1" in
	'-l'|'--headless')
		for i in "${headlessHomeDotfiles[@]}"
		do
			linkOrMove $i
		done
		;;
	'-x'|'--xorg')
		for i in "${homeDotfiles[@]}"
		do
			linkOrMove $i
		done
		;;
	'-i'|'--incremental')
		echo "Not yet implemented! Will have incremental git links later on. Sorry :)"
		exit 0
		;;
	'-h'|'--help')
		usage
		;;
	'-w'|'--wallpapers')
		wallpapers
		;;
	'-v'|'--version')
		version
		;;
	*)
		echo "Unrecognized option \'$1', see --help"
		exit 1
		;;
esac
