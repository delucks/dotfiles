###
### delucks' ~/.bashrc
###
### Last revision: August 8, 2014

[[ $- != *i* ]] && return

### EXPORTS

export EDITOR='vim'
export PAGER='less'

### ALIASES

# Platform Detection & Specific Aliases
case "$OSTYPE" in
	"darwin"*)
		alias macsucks=''
		;;
	"freebsd"*)
		alias ineedsomebsdspecificaliases=''
		;;
	"linux-gnu")
		alias archey='archey --config=~/.config/archey3.cfg'
		#alias steam='LD_PRELOAD="libpthread.so.0 libGL.so.1" __GL_THREADED_OPTIMIZATIONS=1 STEAM_RUNTIME=0 primusrun steam'
		alias arduino='sudo chmod 777 /run/lock && arduino'
		alias valgrinder='valgrind --tool=memcheck $@ --leak-check=full'
		alias ls+='ls -lah | ~/scripts/coloredls'
		alias y='yaourt'
		alias orphan='pacman -Qtdq'
		alias update='sudo pacman -Syu'
		alias reinstall='sudo pacman -Rc $1 && sudo pacman -S $1'
		alias owner='pacman -Qo $(which $1)'
		alias mfat='sudo mount -t vfat /dev/sdb1 /mnt/vfat'
		alias webcam='xawtv -c /dev/video0'
		;;
esac

alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias l='ls -t'
alias ll='ls -aChkopl --group-directories-first --color=auto'
alias lsa='ls -sahp'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias rmspc="find -name '* *' -type f | perl-rename 's/ /_/g'"
alias datehelp='for F in {a..z} {A..Z} :z ::z :::z;do echo $F: $(date +%$F);done|sed "/:[\ \t\n]*$/d;/%[a-zA-Z]/d"'
alias strings='strings -a'

### Functions

function apr {
    err="usage: $FUNCNAME [object]"
    test $# -ne 1 && echo $err && return 1

    IFS=$'\n' manpgs=( $(apropos $1 | grep ^$1) )
    select line in ${manpgs[@]}; do
        n=${line%%) *}; n=${n#* (}
        man ${n} ${line%% *}
    done
}

cl() { #cd and ls at once
	if [ -d "$1" ]; then
		cd "$1"
		ls
	else
		echo "bash: cl: '$1': Directory not found"
	fi
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
	if [ $# -gt 0 ]; then
		ps -fp $(pgrep -f $1)
	else
		echo "Needs at least one argument"
	fi
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

vim()
{
	if [ $# -eq 1 ] && [[ ${1} =~ \.$ ]] && [ ! -f ${1} ] && ls ${1}* > /dev/null 2>&1; then
		command vim ${1}*
	else
		command vim "$@"
	fi  
}

### Prompt

PS1='\u@\h \W; '
#PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
