###
### ~/.zshrc
###

[[ $- != *i* ]] && return

### aliases

source ~/.aliasrc

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

sourcep "$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
cd .

# suffix
alias -g G="| grep"
alias -g L="| less"
alias -g LC='| wc -l'
alias -g C="| column -t"

### prompt

autoload -U colors && colors
case $(id -u) in
	0)
		PROMPT="%(?:%F{blue}root#%F{grey}:%F{grey}%F{red}root?%F{grey})%f%k "
		;;
	*)
    PROMPT="%(?:%F{green}.%F{grey}:%F{grey}%F{red}?%F{grey})%f%k "
		;;
esac

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

### keybinds

bindkey -e
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey -s '^k' '^atime ^M'
bindkey -s '^h' '^aman ^M'
bindkey -s '^p' '^aps aux | grep !!^M'
bindkey -s '^j' '^M'

### exports

export HISTFILE=~/.zsh_history
export SAVEHIST=10000
export SHELL=zsh
