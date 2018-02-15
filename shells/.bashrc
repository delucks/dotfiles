###
### ~/.bashrc
###

[[ $- != *i* ]] && return

### aliases

source $HOME/.aliasrc

### exports / functions

export SHELL=$(which bash)

set -o emacs
bind '"\C-k": "\C-atime \C-m"'
# ideas for more of these: |less
bind '"\C-j;": "\C-m"'
shopt | grep -q autocd && shopt -s autocd # WOW THIS IS AWESOME
stty -ixon  # diable XON/XOFF

### prompt

initializeANSI

_prompt_git() {
  local branch=$(git branch --no-color 2>/dev/null | awk '/\*/{print $NF}')
  local status="$(git status --porcelain --untracked-files=no 2>/dev/null)"
  [ -n "$status" ] && local color="${redf}" || local color="${greenf}"
  [ -n "$branch" ] && echo "[$color$branch${reset}]"
}

_prompt_svn() {
  if ! svn st 2>&1 | grep -q 'not a working'; then
    local message="$(svn st | cut -f1 -d\  | sort | uniq | paste -s -d\  | tr -d ' ')"
    [[ "$message" == *"M"* ]] || [[ "$message" == *"!"* ]] || [[ "$message" == *"C"* ]] && local color="${redf}" || local color="${greenf}"
    echo "[$color$message$reset]"
  fi
}

_prompt_char() {
  if [[ $? == 0 ]]; then echo "${greenf}>${reset}>${greenf}>${reset}"; else echo "${redf}[$?]${reset}"; fi
}

dynamic_prompt() {
  local chr="$(_prompt_char)"
  cmd_exists git && local git="$(_prompt_git)" || local git=""
  cmd_exists svn && local svn="$(_prompt_svn)" || local svn=""
  echo -e "$git$svn $chr"
}

_ssh_complete() {
    COMPREPLY=( $(compgen -W "$(ssh-hosts | paste -s)" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
complete -F _ssh_complete ssh

PS1="\u\[${greenf}\]@\h\[${reset}\] [\D{%m-%d %T}] \W\[\$(dynamic_prompt)\] "
