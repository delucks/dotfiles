###
### ~/.bashrc
###

# Make sure we're in an interactive shell
[[ $- != *i* ]] && return

### aliases

source $HOME/.aliasrc

### history

export HISTCONTROL=ignoredups
shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=$HOME/.shell_history

### exports / functions

set -o emacs
bind '"\C-k": "\C-atime \C-m"'
# ideas for more of these: |less
bind '"\C-j;": "\C-m"'
shopt | grep -q autocd && shopt -s autocd # WOW THIS IS AWESOME
stty -ixon  # diable XON/XOFF

### prompt

# Initialize colors
redf="$(tput setaf 1)"
greenf="$(tput setaf 2)"
reset="$(tput sgr0)"

_prompt_git() {
	local branch=$(git branch --no-color 2>/dev/null | awk '/\*/{print $NF}' | tr -d '()')
  local status="$(git status --porcelain --untracked-files=no 2>/dev/null)"
  [ -n "$status" ] && local color="${redf}" || local color="${greenf}"
  [ -n "$branch" ] && echo "[$color$branch${reset}]"
}

_prompt_svn() {
  if ! svn st 2>&1 | grep -q 'not a working'; then
    local message="$(svn st --ignore-externals | cut -f1 -d\  | sort | uniq | paste -s -d\  | tr -d ' ')"
    [[ "$message" == *"M"* ]] || [[ "$message" == *"!"* ]] || [[ "$message" == *"C"* ]] && local color="${redf}" || local color="${greenf}"
    echo "[$color$message$reset]"
  fi
}

_prompt_char() {
  if [[ $? == 0 ]]; then echo "${greenf}\$${reset}"; else echo "rc ${redf}$?${reset}"; fi
}

dynamic_prompt() {
  local chr="$(_prompt_char)"
  cmd_exists git && local git="$(_prompt_git)" || local git=""
  cmd_exists svn && local svn="$(_prompt_svn)" || local svn=""
  echo -e "$git$svn $chr"
}

FULL_PS1="\[${greenf}\]\h\[${reset}\] \D{%T} \W\[\$(dynamic_prompt)\] "
prompt_reset() { PS1="$FULL_PS1"; }
prompt_maximal() { PS1="\u\[${greenf}\]@\h\[${reset}\] [\D{%m-%d %T} \W\[\$(dynamic_prompt)\] "; }
prompt_minimal() { PS1="$ "; }
prompt_flashy() { PS1="🌵 "; }
PS1="$FULL_PS1"

### spelling correction provided by delucks/multitool

if hash multitool 2>/dev/null; then
  command_not_found_handle() {
    corr=$(suggest-fc "$1")
    test -z "$corr" || echo "Did you mean ${redf}${corr}${reset}?" >&2
    return 127
  }
fi

### completion

_ssh_complete() {
    COMPREPLY=( $(compgen -W "$(sshc hosts | paste -s)" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
complete -F _ssh_complete ssh
