# much more maintainable than a shell script, right?
# originally by delucks 11/24/2014

DOT=`pwd`

all: vim-install \
	media-install \
	shell-install \
	xorg-install \
	git-install \
	misc-install

remove-all: vim-remove \
	media-remove \
	shell-remove \
	xorg-remove \
	git-remove \
	misc-remove

dev-install: vim-install \
	misc-install \
	git-install \
	shell-install

dev-remove: vim-remove \
	misc-remove \
	git-remove \
	shell-remove

vim-install:
	ln -s ${DOT}/.vim ~/.vim
	ln -s ${DOT}/.vimrc ~/.vimrc

vim-remove:
	-@rm -f ~/.vim
	-@rm -f ~/.vimrc

media-install:
	ln -s ${DOT}/.abcde.conf ~/.abcde.conf
	ln -s ${DOT}/.ncmpcpp ~/.ncmpcpp

media-remove:
	-@rm -f ~/.abcde.conf
	-@rm -f ~/.ncmpcpp

shell-install:
	ln -s ${DOT}/.aliasrc ~/.aliasrc
	ln -s ${DOT}/.bashrc ~/.bashrc
	ln -s ${DOT}/.zshrc ~/.zshrc
	ln -s ${DOT}/.tmux.conf ~/.tmux.conf

shell-remove:
	-@rm -f ~/.aliasrc
	-@rm -f ~/.bashrc
	-@rm -f ~/.zshrc
	-@rm -f ~/.tmux.conf

xorg-install:
	ln -s ${DOT}/.compton.conf ~/.compton.conf
	ln -s ${DOT}/.dmenurc ~/.dmenurc
	ln -s ${DOT}/.redshiftgrc ~/.redshiftgrc
	ln -s ${DOT}/.xinitrc ~/.xinitrc
	ln -s ${DOT}/.xmobarrc ~/.xmobarrc
	ln -s ${DOT}/.Xmodmap ~/.Xmodmap
	ln -s ${DOT}/.Xresources ~/.Xresources
	ln -s ${DOT}/.i3 ~/.i3

xorg-remove:
	-@rm -f ~/.compton.conf
	-@rm -f ~/.dmenurc
	-@rm -f ~/.redshiftgrc
	-@rm -f ~/.xinitrc
	-@rm -f ~/.xmobarrc
	-@rm -f ~/.Xmodmap
	-@rm -f ~/.Xresources
	-@rm -f ~/.i3

git-install:
	ln -s ${DOT}/.gitconfig ~/.gitconfig

git-remove:
	-@rm -f ~/.gitconfig

misc-install:
	ln -s ${DOT}/.irssi ~/.irssi

misc-remove:
	-@rm -f ~/.irssi

# TODO: things that need to be copied. these are low priority as most are window manager configs
# .profile
# dwb
# herbstluftwm
# openbox
# ranger
# subtle
