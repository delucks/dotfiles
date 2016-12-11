###
### ~/.bashrc
###

[[ $- != *i* ]] && return

### aliases

source ~/.aliasrc

### exports / functions

export SHELL=$(which bash)

# sorry
set -o emacs
bind '"\C-k": "\C-atime \C-m"'
# ideas for more of these: |less
bind '"\C-j;": "\C-m"'
shopt -s autocd # WOW THIS IS AWESOME

### prompt

initializeANSI

_prompt_git() {
  local branch=$(git branch --no-color 2>/dev/null | sed 's/^\*\ //')
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
  if [[ $? == 0 ]]; then echo "${greenf}.${reset}"; else echo "${redf}?${reset}"; fi
}

dynamic_prompt() {
  local chr=$(_prompt_char)
  local git=$(_prompt_git)
  local svn=$(_prompt_svn)
  echo -e "$git$svn $chr"
}

PS1="\u\[${greenf}\]@\h\[${reset}\] \w\$(dynamic_prompt) "
