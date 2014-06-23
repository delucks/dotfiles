#############################
##### GLOBAL OH-MY-ZSH CONFIG
#############################

ZSH=~/.oh-my-zsh
ZSH_THEME="delucks"
plugins=(git, catimg, pip, systemd)
source $ZSH/oh-my-zsh.sh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#################
##### ZSH OPTIONS
#################

autoload -U compinit
compinit

setopt completealiases
setopt chaselinks
setopt pathdirs
unsetopt correct
unsetopt autoremoveslash

compdef _gnu_generic remind

DISABLE_UNTRACKED_FILES_DIRTY="true"
#DISABLE_CORRECTION="true"

#############
##### EXPORTS
#############

export EDITOR="vim"
export GNUSTEP_USER_ROOT="${HOME}/GNUstep"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-256color
export BUG_PROJECT="/home/jamie/.todo.bug"

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=-r

#############
##### ALIASES
#############

# SVN Aliases
alias sup='svn update'
alias sch='svn checkout $@'
alias ss='svn status'
alias sadd='svn add $@'
alias scm='svn commit'

# GIT Aliases
alias gp='git pull'
alias gc='git commit'
alias gs='git status'

# LS Aliases
alias l='ls -lh --group-directories-first | ~/scripts/coloredls'
alias la='ls -aChkopl --group-directories-first --color=auto'
alias lsg='ls -aChkopl --group-directories-first --color=auto | grep "$@"'
alias ll='ls -G'
alias sl='/usr/bin/sl'

# PACKAGE MANAGEMENT Aliases
alias y='yaourt'
alias orphan='pacman -Qtdq'
alias owner='pacman -Qo $(which $1)'
alias hist='history|grep "pacman\ -S\ "'

# BEET Aliases
alias bim='beet im'
alias bls='beet ls'
alias brm='beet remove'
alias bvr='beet version'

# MISC Aliases
alias whereami='uname -n'
alias d='date +%R'
alias bar="~/dev/bar/bar -p -f '-*-tamsyn-medium-r-*-*-17-*-*-*-*-*-iso8859-*,-*-stlarch-medium-r-*-*-10-*-*-*-*-*-iso10646-*' -B #dadada -F #8f8f8f"
alias ixit='curl -F "f:1=<-" ix.io'
alias ranger='ranger 2> /dev/null'
alias stog='amixer set Speaker toggle'
alias hc='herbstclient'
alias violet='wmname LG3D && violet'
alias wp='/home/jamie/dev/wp/wp'
alias archey='archey --config=~/.config/archey3.cfg'
alias sizer='du -hs "$@" | sort -h'
alias valgrinder='valgrind --tool=memcheck $@ --leak-check=full'
alias mfat='sudo mount -t vfat /dev/sdb1 /mnt/vfat'
#alias webcam='mplayer tv://'
alias webcam='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot'
alias manp='python2 manage.py'
alias wgot='wget -e robots=off -r -nc -np '
alias rot13='tr "a-zA-Z" "n-za-mN-ZA-M"'
alias iploc='curl ipinfo.io/$(dig $1 +short)'

# SUFFIX Aliases
alias -g G="| grep"
alias -g L="| less"
alias -g LC='| wc -l'
alias -g C="| column -t"

###############
##### FUNCTIONS
###############

case $TERM in
	screen*)
		precmd(){
			# Restore tmux-title to 'zsh'
			printf "\033kzsh\033\\"
			# Restore urxvt-title to 'zsh'
			print -Pn "\e]2;zsh:%~\a"
		}
		preexec(){
			# set tmux-title to running program
			printf "\033k$(echo "$1" | cut -d" " -f1)\033\\"
			# set urxvt-title to running program
			print -Pn "\e]2;zsh:$(echo "$1" | cut -d" " -f1)\a"
    }
    ;;
esac

#function apr {
#    err="usage: $FUNCNAME [object]"
#    test $# -ne 1 && echo $err && return 1
#
#    IFS=$'\n' manpgs=( $(apropos $1 | grep ^$1) )
#    select line in ${manpgs[@]}; do
#        n=${line%%) *}; n=${n#* (}
#        man ${n} ${line%% *}
#    done
#}

function wiki {
	if [ $# -eq 1 ]; then
		foo=4
	else
		foo=$2
	fi

	curl -s -L -d "search=$1" http://en.wikipedia.org/w/index.php | grep '<p>\|<h3>\|<h2>' | head -n$foo | w3m -T text/html -dump | sed 's/(Listen.*)//g'
	#curl -s -L -d "search=Linux" http://en.wikipedia.org/w/index.php | grep '<p>' | head -n2 | w3m -T text/html -dump | sed 's/\^\[.*\]//g'
}

function musicopy {
	cd ~/music/
	mpc search "$@" | while read line; do
		sudo cp $line /mnt/vfat
	done
}

vim()
{
	if [ $# -eq 1 ] && [[ ${1} =~ \.$ ]] && [ ! -f ${1} ] && ls ${1}* > /dev/null 2>&1; then
		command vim ${1}*
	else
		command vim "$@"
	fi  
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