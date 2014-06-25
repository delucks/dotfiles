#!/bin/bash
# Author: delucks

set -e

function linkOrMove {
	echo "Processing ~/dotfiles/$1 to ~/.$1"
	ln -s ~/dotfiles/$1 ~/$1
	if [ $? -ne 0 ]; then
		if [ -h ~/$1 ]; then
			echo "WARNING A symlink already exists for $1. Unlinking it."
			unlink ~/$1
			ln -s ~/dotfiles/$1 ~/$1
			[ $? -eq 0 ] && echo "~/$1 linked successfully."
		else
			echo "~/$1 exists. Copying it to ~/$1.bak"
			cp ~/$1{,.bak}
			echo "Now removing the old ~/$1"
			rm ~/$1
			echo "Now linking ~/$1"
			ln -s ~/dotfiles/$1 ~/$1
			[ $? -eq 0 ] && echo "~/$1 linked successfully."
		fi
	else
		echo "~/$1 linked successfully."
	fi
}

function usage {
	echo "usage: setup.sh [option]"
	echo
	echo "Options:"
	echo "    -l, --headless    - Install everything not X-specific"
	echo "    -a, --all         - Install everything"
	echo "    -s, --software    - Install everything, and try to get the correct software installed (requires sudo)"
	echo "    -h, --help        - Show this help message"
	echo "    -v, --version     - Show a quick version summary"
	exit
}

function version {
	echo "setup.sh by delucks@github.com"
	echo
	echo "Contact:      jluck@udel.edu"
	echo "Version:      0.6"
	echo
	echo "Thanks for using my dotfiles!"
	exit
}

case "$1" in
	'-l'|'--headless')
		dotfiles=(".bashrc" ".irssi" ".tmux.conf" ".vim" ".vimrc" ".zshrc" ".abcde.conf" ".gitconfig" ".ncmpcpp")
		;;
	'-a'|'--all')
		dotfiles=(".bashrc" ".irssi" ".tmux.conf" ".vim" ".vimrc" ".zshrc" ".abcde.conf" ".gitconfig" ".ncmpcpp" ".Xresources" ".xinitrc" ".Xmodmap" ".compton.conf" ".dmenurc" ".i3" ".redshiftgrc" ".xmobarrc")
		mkdir -p ~/.config
		cp -R ~/dotfiles/herbstluftwm/ ~/.config/herbstluftwm
		;;
	'-h'|'--help')
		usage
		;;
	'-v'|'--version')
		version
		;;
	*)
		echo "Unrecognized option \'$1', see --help"
		exit 1
		;;
esac

echo "Installing delucks/scripts repo"
git clone https://github.com/delucks/scripts ~/scripts
echo "Installing oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
echo "Installing zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/zsh-syntax-highlighting

for item in "${dotfiles[@]}"
do
	linkOrMove $item
done

cp ~/dotfiles/delucks.zsh-theme ~/.oh-my-zsh/themes/
mkdir -p ~/.config
cp -R ~/dotfiles/ranger/ ~/.config/ranger

echo "Installing Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Installing vim plugins managed by Vundle"
vim +PluginInstall! +qall
