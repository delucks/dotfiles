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
shopt -s autocd
stty -ixon  # diable XON/XOFF

### prompt

# Initialize colors
redf="$(tput setaf 1)"
greenf="$(tput setaf 2)"
bluef="$(tput setaf 4)"
magentaf="$(tput setaf 5)"
cyanf="$(tput setaf 6)"
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

__prompt_command() {
  local lastExit="$?"
  cmd_exists git && local git="$(_prompt_git)" || local git=""
  cmd_exists svn && local svn="$(_prompt_svn)" || local svn=""
  # hostname HH:MM:SS ~
  PS1="\[${magentaf}\]\h\[${reset}\] \[${cyanf}\]\D{%T}\[${reset}\] \w "
  if [ "$lastExit" -eq 0 ]; then
    PS1+='$ '
  else
    PS1+="${redf}${lastExit}${reset} "
  fi
}

PROMPT_COMMAND=__prompt_command

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
    COMPREPLY=( $(compgen -W "$(awk '/^Host/{print $2}' "$HOME/.ssh/config"| paste -s)" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
complete -F _ssh_complete ssh
