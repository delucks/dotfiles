###
### zsh configurations
###
### Last edit: November 27, 2014

### prompt

# set dynamic right prompt
precmd() {
	# first check if we're in an ssh session. if so display the user and hostname
	if [ ! -z "$SSH_CONNECTION" ]; then
		ssh_prompt=" %n%F{green}@%m%f%k" # we're in an active SSH connection
	else
		unset ssh_prompt
	fi
	# then, check if the shell currently opened was created by ranger fm
	if [ -n "$RANGER_LEVEL" ]; then
		ranger_prompt=" %F{red}[opened by ranger]%f"
	else
		unset ranger_prompt
	fi
	# then, check if we're in a git repo. if so, display the current branch and a color to indicate if the working state is clean
	if [ "${git_pwd_is_worktree}" = 'true' ]; then
    git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
    git_branch="${git_branch##*/}"
    git_branch="${git_branch:-no branch}"
		if [ "${git_worktree_is_bare}" = 'false' ] && [ -n "$(git status --untracked-files='no' --porcelain)" ]; then
			git_prompt="%F{red}(${git_branch})%f" # dirty
		else	
			git_prompt="%F{green}(${git_branch})%f" # clean
		fi
	else
			unset git_prompt
	fi
	RPROMPT="%~${git_prompt}${ssh_prompt}${ranger_prompt}"
}

chpwd() {
	if [ -d '.git' ] || [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
		git_pwd_is_worktree='true'
		git_worktree_is_bare="$(git config core.bare)"
	else
		unset git_branch git_worktree_is_bare
		git_pwd_is_worktree='false'
	fi
}

x() {
	python2 ~/scripts/x86.py $1 | lynx -stdin -dump
}

hex() {
	python2 -c "print hex($1 $2 $3)"
}

autoload -U colors && colors
case $(id -u) in
	0)
		PROMPT="%(?:%F{green}root#%F{grey}:%F{grey}%F{red}root?%F{grey})%f%k "
		;;
	*)
		PROMPT="%(?:%F{green}⚡%F{grey}:%F{grey}%F{red}?%F{grey})%f%k "
		;;
esac
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### zsh options

autoload -U compinit promptinit
compinit
promptinit

setopt completealiases
setopt sharehistory
setopt completeinword
setopt chaselinks
setopt pathdirs
setopt correct
unsetopt autoremoveslash

compdef _gnu_generic remind

DISABLE_UNTRACKED_FILES_DIRTY="true"
#DISABLE_CORRECTION="true"

### exports

export EDITOR="vim"
export GNUSTEP_USER_ROOT="${HOME}/GNUstep"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-256color
export PATH="/home/jamie/dev/go/bin:/home/jamie/bin:/home/jamie/.gem/ruby/2.1.0/bin:$PATH"
export GOBIN="/home/jamie/dev/go/bin"
export GOPATH="/home/jamie/dev/go"
export HISTFILE=~/.zsh_history
export SAVEHIST=1

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=-r

### aliases

source ~/.aliasrc

# suffix
alias -g G="| grep"
alias -g L="| less"
alias -g LC='| wc -l'
alias -g C="| column -t"

### functions

function wiki {
	if [ $# -eq 1 ]; then
		foo=4
	else
		foo=$2
	fi

	curl -s -L -d "search=$1" http://en.wikipedia.org/w/index.php | grep '<p>\|<h3>\|<h2>' | head -n$foo | w3m -T text/html -dump | sed 's/(Listen.*)//g'
	#curl -s -L -d "search=Linux" http://en.wikipedia.org/w/index.php | grep '<p>' | head -n2 | w3m -T text/html -dump | sed 's/\^\[.*\]//g'
}

b() {
	if [ $# -eq 0 ]; then
		cat /sys/class/backlight/intel_backlight/brightness
	else
		echo "${1}" | sudo tee -a /sys/class/backlight/intel_backlight/brightness
	fi
}

trans() {
	curl --upload-file "$1" https://transfer.sh/$(basename $1);
}

paste() {
	cat "$1" | xclip -i
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
