###
###  ~/.bashrc
###

[[ $- != *i* ]] && return

### EXPORTS

export EDITOR='vim'
export PAGER='less'
export LS_COLORS=
# sorry
set -o emacs

### ALIASES

source ~/.aliasrc

### Functions

function apr {
    err="usage: $FUNCNAME [object]"
    test $# -ne 1 && echo $err && return 1

    IFS=$'\n' manpgs=( $(apropos $1 | grep ^$1) )
    select line in ${manpgs[@]}; do
        n=${line%%) *}; n=${n#* (}
        man ${n} ${line%% *}
    done
}

cl() { #cd and ls at once
	if [ -d "$1" ]; then
		cd "$1"
		ls
	else
		echo "bash: cl: '$1': Directory not found"
	fi
}

mkcd() {
  mkdir -p "$1"
  cd "$1"
}

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

valhalla() {
	if [ "$#" == "0" ]; then
		make
		valgrind --tool=memcheck ./*.exe --leak-check=full
	else
		g++ -g "$1" -o "$(basename $1).out" && valgrind --tool=memcheck ./"$(basename $1).out" "${@:2}" --leak-check=full
	fi
}

psgrep() {
	if [ $# -gt 0 ]; then
		ps -fp $(pgrep -f $1)
	else
		echo "Needs at least one argument"
	fi
}

cfat() {
	sudo mount -t vfat /dev/sdb1 /mnt/vfat
	echo "Mounted."
	sudo cp $@ /mnt/vfat/
	echo "Copied."
	read -p "Press Enter to Unmount:"
	sudo umount /mnt/vfat
	echo "Unmounted."
}

### Prompt

#PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;32m\]\u\[\033[0;37m\]@\[\033[0;30m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
