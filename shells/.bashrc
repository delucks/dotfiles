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

PS1="\u\[${greenf}\]@\h\[${reset}\] \w \$(if [[ \$? == 0 ]]; then echo \"\[${greenf}\].\[${reset}\]\"; else echo \"\[${redf}\]?\[${reset}\]\"; fi) "