###
### Solaris ~/.bashrc
###

# Make sure we're in an interactive shell
[[ $- != *i* ]] && return

HOME="${HOME:-/export/home/delucks}"
export PATH="/usr/bin:/usr/sbin:/usr/openwin/bin:/usr/ucb:/usr/sfw/bin"
export EDITOR=vi
hash vim 2>/dev/null && export EDITOR=vim
export PAGER='less'

### exports / functions

set -o emacs
stty -ixon  # diable XON/XOFF

### prompt

# Initialize colors. OpenBSD takes extra, seemingly useless, parameters to tput
# https://marc.info/?l=openbsd-bugs&m=160951076227330&w=2
reset="$(tput sgr0)"
case "$OSTYPE" in
  openbsd*)
    redf="$(tput setaf 1 0 0)"
    greenf="$(tput setaf 2 0 0)"
    bluef="$(tput setaf 4 0 0)"
    magentaf="$(tput setaf 5 0 0)"
    cyanf="$(tput setaf 6 0 0)"
    ;;
  *)
    redf="$(tput setaf 1)"
    greenf="$(tput setaf 2)"
    bluef="$(tput setaf 4)"
    magentaf="$(tput setaf 5)"
    cyanf="$(tput setaf 6)"
    ;;
esac

# add a directory to PATH, but only if it exists and if it's not already in PATH
pathappend() {
  for pathname in "$@"; do
    if ! test -d "$pathname"; then
      continue
    fi
    case "$PATH" in
      *:$pathname:*)
        # path exists in the middle
        continue
        ;;
      *:$pathname)
        # path exists on the end
        continue
        ;;
      $pathname:*)
        # path exists in the beginning
        continue
        ;;
      "$pathname")
        # this is the only entry in PATH
        continue
        ;;
      *)
        # path does not yet exist in PATH
        PATH="${PATH:+"$PATH:"}$pathname"
        ;;
    esac
  done
}

pathprepend() {
  for pathname in "$@"; do
    if ! test -d "$pathname"; then
      continue
    fi
    case "$PATH" in
      *:$pathname:*)
        # path exists in the middle
        continue
        ;;
      *:$pathname)
        # path exists on the end
        continue
        ;;
      $pathname:*)
        # path exists in the beginning
        continue
        ;;
      "$pathname")
        # this is the only entry in PATH
        continue
        ;;
      *)
        # path does not yet exist in PATH
        PATH="${pathname}${PATH:+":$PATH"}"
        ;;
    esac
  done
}

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
  hash git 2>/dev/null && local git="$(_prompt_git)" || local git=""
  hash svn 2>/dev/null && local svn="$(_prompt_svn)" || local svn=""
  # hostname HH:MM:SS ~
  result="\[${magentaf}\]\h\[${reset}\] \[${cyanf}\]\t\[${reset}\] \w${git}${svn} "
  if [ "$lastExit" -eq 0 ]; then
    result=$result'$ '
  else
    result="${result}${redf}${lastExit}${reset} "
  fi
  PS1="$result"
}

PROMPT_COMMAND=__prompt_command

### completion

_ssh_complete() {
    COMPREPLY=( $(compgen -W "$(awk '/^Host/{print $2}' "$HOME/.ssh/config"| paste -s)" -- ${COMP_WORDS[COMP_CWORD]}) )
    return 0
}
complete -F _ssh_complete ssh

### aliases

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias gita='git add'
alias gitd='git diff'
alias gits='git status'
alias gitl='git log --all --graph --pretty=format:"%Cred%h%Creset %C(bold blue)%an%Creset :%C(yellow)%d%Creset %s %Cgreen(%cr) %Creset"'

alias search="w3m 'https://lite.duckduckgo.com'"
alias mountusb="mount -F pcfs /dev/dsk/c7t0d0s0 /mnt"

# tx and ta are my two tmux manipulation functions
#
# tx() creates a tmux session at a path, the current directory by default
# ta() attaches a tmux session (using fzf if available)

tx() {
  # Opens a tmux session named after the basename of a path
  DIR="${1:-.}"
  RESOLVED="$(cd "$DIR" 2>/dev/null && pwd -P)"  # Cross-platform, readlink is Linux specific
  SESSION_NAME="$(basename "$RESOLVED" | tr '.' '_')"
  # Older versions of tmux do not support the "-c dir_for_session" flag
  cd "$RESOLVED" && tmux new-session -A -s "${SESSION_NAME}"
}

ta() {
  if hash fzf 2>/dev/null; then
    # shellcheck disable=SC2033
    SESSION=$(tmux ls -F '#{session_name}' | fzf)
    test -z "$SESSION" && return 1
    tmux attach-session -t "$SESSION"
    return $?
  fi
  tmux a
}

### path / software

pathprepend "/opt/csw/bin"
pathappend "/usr/local/bin"

export PHOTOSHOP_ROOT="${HOME}/AdobePhotoshop3"
pathappend "/usr/adobe/Photoshop_3.0.1/bin"

swd8() {
  umount /mnt; lofiadm -d /dev/lofi/8; lofiadm -a "$1" /dev/lofi/8 && mount -F hsfs -o ro /dev/lofi/8 /mnt
}

alias x='export TERM=xterm'
