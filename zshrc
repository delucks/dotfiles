#############################
##### GLOBAL OH-MY-ZSH CONFIG
#############################

ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="jluck"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# SSH Aliases

source ~/.ssh_aliases

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
alias la='ls -aChkopl --group-directories-first --color=auto'
alias lsg='ls -aChkopl --group-directories-first --color=auto | grep "$@"'
alias l='ls -G'

# PACKAGE MANAGEMENT Aliases
alias y='yaourt'
alias orphan='pacman -Qtdq'
alias owner='pacman -Qo $(which $1)'

# BEET Aliases
alias bim='beet im'
alias bls='beet ls'
alias brm='beet remove'
alias bvr='beet version'

# MISC Aliases
alias ranger='ranger 2> /dev/null'
alias stog='amixer set Speaker toggle'
alias hc='herbstclient'
alias violet='wmname LG3D && violet'
alias wp='/home/jamie/dev/wp/wp'
alias archey='archey --config=~/.config/archey3.cfg'
alias sizer='du -hs "$@" | sort -h'
alias valgrinder='valgrind --tool=memcheck $@ --leak-check=full'
alias mfat='sudo mount -t vfat /dev/sdb1 /mnt/vfat'
alias webcam='mplayer tv://'
alias manp='python2 manage.py'

# SUFFIX Aliases
alias -g G="| grep"
alias -g L="| less"
alias -g LC='| wc -l'

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
