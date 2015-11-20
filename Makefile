# much more maintainable than a shell script, right?
# originally by delucks 11/24/2014
# updated 08/31/2015

DOT=`pwd`

all: vim-install \
	shell-install \
	git-install \
	env-install

dev-install: vim-install \
	env-install \
	git-install \
	shell-install

env-install:
	git clone https://github.com/delucks/scripts ~/scripts
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh-syntax-highlighting

vim-install:
	ln -s ${DOT}/.vim ~/.vim
	ln -s ${DOT}/.vimrc ~/.vimrc
	git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

media-install:
	ln -s ${DOT}/.abcde.conf ~/.abcde.conf
	ln -s ${DOT}/.ncmpcpp ~/.ncmpcpp

shell-install:
	ln -s ${DOT}/.aliasrc ~/.aliasrc
	touch ~/.localaliasrc
	ln -s ${DOT}/.bashrc ~/.bashrc
	ln -s ${DOT}/.zshrc ~/.zshrc
	ln -s ${DOT}/.tmux.conf ~/.tmux.conf
	mkdir -p ~/.config
	cp -r ${DOT}/ranger ~/.config/ranger
	ln -s ${DOT}/.ackrc ~/.ackrc

xorg-install:
	ln -s ${DOT}/.compton.conf ~/.compton.conf
	ln -s ${DOT}/.dmenurc ~/.dmenurc
	ln -s ${DOT}/.redshiftgrc ~/.redshiftgrc
	ln -s ${DOT}/.xinitrc ~/.xinitrc
	ln -s ${DOT}/.xmobarrc ~/.xmobarrc
	ln -s ${DOT}/.Xmodmap ~/.Xmodmap
	ln -s ${DOT}/.Xresources ~/.Xresources
	ln -s ${DOT}/.i3 ~/.i3
	ln -s ${DOT}/.i3blocks.conf ~/.i3blocks.conf
	mkdir -p ~/.config
	ln -s ${DOT}/dunstrc ~/.config/dunstrc
	cp -r ${DOT}/herbstluftwm ~/.config/herbstluftwm
	cp -r ${DOT}/openbox ~/.config/openbox

git-install:
	ln -s ${DOT}/.gitconfig ~/.gitconfig

misc-install:
	ln -s ${DOT}/.irssi ~/.irssi
	cp -r ${DOT}/.weechat ~/.weechat
	ln -s ${DOT}/.gdbinit ~/.gdbinit
	git clone https://github.com/delucks/colorman ~/colorman

remove-all: vim-remove \
	shell-remove \
	git-remove \
	env-remove

dev-remove: vim-remove \
	git-remove \
	env-remove \
	shell-remove

env-remove:
	-@rm -r ~/scripts
	-@rm -r ~/.zsh-syntax-highlighting

vim-remove:
	-@rm -f ~/.vim
	-@rm -f ~/.vimrc

media-remove:
	-@rm -f ~/.abcde.conf
	-@rm -f ~/.ncmpcpp

shell-remove:
	-@rm -f ~/.aliasrc
	-@rm -f ~/.bashrc
	-@rm -f ~/.zshrc
	-@rm -f ~/.tmux.conf
	-@rm -r ~/.config/ranger
	-@rm -f ~/.ackrc

xorg-remove:
	-@rm -f ~/.compton.conf
	-@rm -f ~/.dmenurc
	-@rm -f ~/.redshiftgrc
	-@rm -f ~/.xinitrc
	-@rm -f ~/.xmobarrc
	-@rm -f ~/.Xmodmap
	-@rm -f ~/.Xresources
	-@rm -f ~/.i3
	-@rm -f ~/.i3blocks.conf
	-@rm -rf ~/.config/herbstluftwm
	-@rm -rf ~/.config/openbox

git-remove:
	-@rm -f ~/.gitconfig

misc-remove:
	-@rm -f ~/.irssi
	-@rm -f ~/.weechat
	-@rm -f ~/.gdbinit
	-@rm -rf ~/colorman

backup-all:
	if [ -a ~/.bashrc ] ; \
	then \
		mv ~/.bashrc ~/.bashrc.bak ; \
	fi;
	if [ -a ~/.zshrc ] ; \
	then \
		mv ~/.zshrc ~/.zshrc.bak ; \
	fi;
	if [ -a ~/.vimrc ] ; \
	then \
		mv ~/.vimrc ~/.vimrc.bak ; \
	fi;
	if [ -a ~/.vim ] ; \
	then \
		mv ~/.vim ~/.vim.bak ; \
	fi;
