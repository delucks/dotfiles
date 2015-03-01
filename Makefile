# much more maintainable than a shell script, right?
# originally by delucks 11/24/2014

DOT=`pwd`

all: vim-install \
	media-install \
	shell-install \
	xorg-install \
	git-install \
	env-install \
	misc-install

remove-all: vim-remove \
	media-remove \
	shell-remove \
	xorg-remove \
	git-remove \
	env-remove \
	misc-remove

dev-install: vim-install \
	env-install \
	misc-install \
	git-install \
	shell-install

dev-remove: vim-remove \
	misc-remove \
	git-remove \
	env-remove \
	shell-remove

env-install:
	git clone https://github.com/delucks/scripts ~/scripts
	git clone https://github.com/delucks/colorman ~/colorman
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh-syntax-highlighting

env-remove:
	-@rm -r ~/scripts
	-@rm -r ~/.zsh-syntax-highlighting

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
	cp -r ${DOT}/ranger ~/.config/ranger

shell-remove:
	-@rm -f ~/.aliasrc
	-@rm -f ~/.bashrc
	-@rm -f ~/.zshrc
	-@rm -f ~/.tmux.conf
	-@rm -r ~/.config/ranger

xorg-install:
	ln -s ${DOT}/.compton.conf ~/.compton.conf
	ln -s ${DOT}/.dmenurc ~/.dmenurc
	ln -s ${DOT}/.redshiftgrc ~/.redshiftgrc
	ln -s ${DOT}/.xinitrc ~/.xinitrc
	ln -s ${DOT}/.xmobarrc ~/.xmobarrc
	ln -s ${DOT}/.Xmodmap ~/.Xmodmap
	ln -s ${DOT}/.Xresources ~/.Xresources
	ln -s ${DOT}/.i3 ~/.i3
	cp -r ${DOT}/herbstluftwm ~/.config/herbstluftwm
	cp -r ${DOT}/openbox ~/.config/openbox

xorg-remove:
	-@rm -f ~/.compton.conf
	-@rm -f ~/.dmenurc
	-@rm -f ~/.redshiftgrc
	-@rm -f ~/.xinitrc
	-@rm -f ~/.xmobarrc
	-@rm -f ~/.Xmodmap
	-@rm -f ~/.Xresources
	-@rm -f ~/.i3
	-@rm -rf ~/.config/herbstluftwm
	-@rm -rf ~/.config/openbox

git-install:
	ln -s ${DOT}/.gitconfig ~/.gitconfig

git-remove:
	-@rm -f ~/.gitconfig

misc-install:
	ln -s ${DOT}/.irssi ~/.irssi
	cp -r ${DOT}/.weechat ~/.weechat
	ln -s ${DOT}/.gdbinit ~/.gdbinit

misc-remove:
	-@rm -f ~/.irssi
	-@rm -f ~/.weechat
	-@rm -f ~/.gdbinit

# TODO:
# .profile
# dwb
# subtle
