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

_prompt_char() {
  if [[ $? == 0 ]]; then echo "${greenf}.${reset}"; else echo "${redf}?${reset}"; fi
}

dynamic_prompt() {
  local chr=$(_prompt_char)
  local git=$(_prompt_git)
  echo -e "$git $chr"
}

PS1="\u\[${greenf}\]@\h\[${reset}\] \w\$(dynamic_prompt) "
