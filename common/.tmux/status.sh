#!/usr/bin/env bash

# give me basic system stats for tmux statusline

if [[ "$OSTYPE" == "darwin"* ]]
then
  memcmd() {
    PAGESZ=$(sysctl hw.pagesize | awk '{print $NF}')
    FREE=$(( $(vm_stat | awk '/free/ {gsub(/\./, "", $3); print $3}') * PAGESZ))
    TOTAL=$(sysctl hw.memsize | awk '{print $2}')
    RATIO=$(bc -l <<< "$FREE/$TOTAL*100")
    printf '%3.1f' $RATIO
    echo %
  }
  loadcmd() {
    uptime | rev | cut -d' ' -f '1-3' | rev
  }
elif [[ "$OSTYPE" == "freebsd"* ]]
then
  memcmd() {
    avail=$(sysctl hw.physmem | awk '{print $2}')
    used=$(vmstat -H | tail -1 | awk '{print $5}')
    echo "$((used/avail))%"
  }
  loadcmd() {
    uptime | rev | cut -d' ' -f '1-3' | rev
  }
else
  # assume linux
  memcmd() {
    free | awk '/Mem/{PERC=$NF/$2*100.0; printf "%3.1f%\n", PERC}'
  }
  loadcmd() {
    cut -d' ' -f '1-3' /proc/loadavg
  }
fi

case $1 in
  load)
    loadcmd
    ;;
  unix)
    date +%s
    ;;
  memory|mem)
    memcmd
    ;;
esac
