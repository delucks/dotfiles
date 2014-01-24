# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# dpoggi is cool, kphoen, jnrowe, mortalscumbag, nanotech, nebirhos, pygmalion, gnzh
ZSH_THEME="jluck"
#autoload -U promptinit
#promptinit

#PROMPT="%{$fg[cyan]%B%3d %b$reset_color» %}"

export EDITOR="vim"

# Aliases
alias g9up='cd /home/jamie/dev/class/CISC275/group9 && svn up'
alias g9='cd /home/jamie/dev/class/CISC275/group9'
alias sup='svn update'
alias sch='svn checkout $@'
alias ss='svn status'
alias sadd='svn add $@'
alias scm='svn commit'

alias ls='ls -aChkopl --group-directories-first --color=auto'
alias lsg='ls -aChkopl --group-directories-first --color=auto | grep "$@"'
alias l='ls -alG'

alias rconf='vim ~/.config/ranger/rc.conf'
alias ra='ranger'
alias ranger='ranger 2> /dev/null'
alias kwf='kill -9 $(pgrep "$1")'
alias ipwd='sudo ip link set dev wlan0 down'
alias stog='amixer set Speaker toggle'
alias hc='herbstclient'
alias violet='wmname LG3D && violet'
alias wp='/home/jamie/dev/wp/wp'

alias y='yaourt'
alias orphan='pacman -Qtdq'
alias owner='pacman -Qo $(which $1)'

alias bim='beet im'
alias bls='beet ls'
alias brm='beet remove'
alias bvr='beet version'

alias archey='archey --config=~/.config/archey3.cfg'
alias arduino='sudo chmod 777 /run/lock && arduino'
alias color='~/scripts/colors'

source ~/.ssh_aliases

alias sizer='du -hs "$@" | sort -h'
alias valgrinder='valgrind --tool=memcheck $@ --leak-check=full'
alias mfat='sudo mount -t vfat /dev/sdb1 /mnt/vfat'

alias webcam='mplayer tv://'

alias -g G="| grep"
alias -g L="| less"
alias -g LC='| wc -l'

# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# CASE_SENSITIVE="true"

autoload -U compinit
compinit

setopt completealiases
setopt chaselinks
setopt pathdirs
unsetopt correct
unsetopt autoremoveslash

compdef _gnu_generic remind

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=-r

source $ZSH/oh-my-zsh.sh

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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
