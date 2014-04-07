# --------------------------------------------------------------------------
# Jamie Luck's ~/.bashrc
# --------------------------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Exports ------------------------------------------------------------------

export EDITOR='vim'
export PAGER='less'
export GNUSTEP_USER_ROOT="${HOME}/GNUstep"

# Aliases ------------------------------------------------------------------

# Default Program Enhancements
alias archey='archey --config=~/.config/archey3.cfg'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
#alias steam='LD_PRELOAD="libpthread.so.0 libGL.so.1" __GL_THREADED_OPTIMIZATIONS=1 STEAM_RUNTIME=0 primusrun steam'
alias arduino='sudo chmod 777 /run/lock && arduino'
alias music='ncmpcpp'
alias nitronicrush='cd ~/.wine/drive_c/Program\ Files/Digipen/Nitronic\ Rush/ && primusrun wine NitronicRush.exe'
alias valgrinder='valgrind --tool=memcheck $@ --leak-check=full'
alias zipc='zip $1 *.cpp *.h *.txt'

# LS Alias Tree
alias ls+='ls -lah | ~/scripts/coloredls'
alias l='ls -t'
alias ll='ls -aChkopl --group-directories-first --color=auto'
alias lll='ls -aChkopl --group-directories-first --color=auto | less'
alias lsa='ls -sahp'
alias lsd='ls -sahp --color=auto'
alias lsg='ls -sahp --color=auto | grep $1'

# CD Alias Tree
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# WM Specific Aliases
alias vconf='vim ~/.vimrc'

# Removable Media
alias usbme='sudo dd bs=4M if=$1 of=/dev/sdb'
alias mfat='sudo mount -t vfat /dev/sdb1 /mnt/vfat'

# Pacman Aliases
alias y='yaourt'
alias orphan='pacman -Qtdq'
alias update='sudo pacman -Syu'
alias reinstall='sudo pacman -Rc $1 && sudo pacman -S $1'
alias owner='pacman -Qo $(which $1)'

# For Lolz
alias webcam='xawtv -c /dev/video0'
alias juan_gonzalez='echo "JUANNNNNN GONNNZAAAAALEZZZZZZZ"'
alias woo='fortune'
alias lds='echo "Crazy Mormon Morons"'

# Miscellany
alias todo='vim ~/Dropbox/Documents/UD/todo.txt'
alias poweroff='shutdown now -hP'
alias rmspc="find -name '* *' -type f | perl-rename 's/ /_/g'" #Change to type f for files
alias datehelp='for F in {a..z} {A..Z} :z ::z :::z;do echo $F: $(date +%$F);done|sed "/:[\ \t\n]*$/d;/%[a-zA-Z]/d"'
alias sizer='du -hs "$@" * | sort -h'
alias volume="amixer | grep '\[*\]' | awk '{print $5}' | head -n 1"
alias nam='apr $@'

# Functions ----------------------------------------------------------------

# search and browse manpages interactively
function apr {
    err="usage: $FUNCNAME [object]"
    test $# -ne 1 && echo $err && return 1

    IFS=$'\n' manpgs=( $(apropos $1 | grep ^$1) )
    select line in ${manpgs[@]}; do
        n=${line%%) *}; n=${n#* (}
        man ${n} ${line%% *}
    done
}

ex() { #Because I can never remember all that xjf garbage
  if [ -f $1 ] ; then
    case $1 in
			*.tar.bz2) tar xjf $1	;;
			*.tar.gz) tar xzf $1	;;
			*.bz2) bunzip2 $1	;;
			*.rar) rar x $1		;;
			*.gz) gunzip $1		;;
			*.tar) tar xf $1	;;
			*.tbz2) tar xjf $1	;;
			*.tgz) tar xzf $1	;;
			*.zip) unzip $1		;;
			*.Z) uncompress $1	;;
			*.7z) 7z x $1		;;
			*) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' cannot be extracted via ex()"
  fi
}

cl() { #cd and ls at once
if [ -d "$1" ]; then
	cd "$1"
	ls
else
	echo "bash: cl: '$1': Directory not found"
fi
}

myip() {
  lynx -dump http://icanhazip.com/
}

mkcd() {
  mkdir -p "$1"
  cd "$1"
}

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

say() {
	if [[ "${1}" =~ -[a-z]{2} ]]; then
		local lang=${1#-};
		local text="${*#$1}";
	else 
		local lang=${LANG%_*};
		local text="$*";
	fi;
	mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ;
}

valhalla() {
	if [ "$#" == "0" ]; then
		make
		valgrind --tool=memcheck ./*.exe --leak-check=full
	else
		g++ -g "$1" -o "$(basename $1).out" && valgrind --tool=memcheck ./"$(basename $1).out" "${@:2}" --leak-check=full
	fi
}

psgrep() {
	ps -fp $(pgrep -f $@)
}

cfat() {
	sudo mount -t vfat /dev/sdb1 /mnt/vfat
	echo "Mounted."
	sudo cp $@ /mnt/vfat/
	echo "Copied."
	read -p "Press Enter to Unmount:"
	sudo umount /mnt/vfat
	echo "Unmounted."
}

swg() {
	if [ "$#" == "0" ]; then
		cat ~/Pictures/wallmood.txt
	else
		echo $1 > ~/Pictures/wallmood.txt
	fi
}

vim()
{
	if [ $# -eq 1 ] && [[ ${1} =~ \.$ ]] && [ ! -f ${1} ] && ls ${1}* > /dev/null 2>&1; then
		command vim ${1}*
	else
		command vim "$@"
	fi  
}

# PS1 Settings -------------------------------------------------------------
PS1='[\u@\h \W]\$ '
#PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

#cat ~/.motd
