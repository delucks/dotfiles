#!/usr/bin/env bash

# give me basic system stats for tmux statusline

if [[ "$OSTYPE" == "darwin"* ]]
then
  memcmd() {
    PAGESZ=$(sysctl -n hw.pagesize)
    FREE=$(( $(vm_stat | awk '/free/ {gsub(/\./, "", $3); print $3}') * PAGESZ))
    TOTAL=$(sysctl -n hw.memsize)
    RATIO=$(bc -l <<< "$FREE/$TOTAL*100")
    printf '%3.1f' $RATIO
    echo %
  }
  loadcmd() {
    uptime | rev | cut -d' ' -f '1-3' | rev
  }
  cpucmd() {
    sysctl -n hw.ncpu
  }
elif [[ "$OSTYPE" == "freebsd"* ]]
then
  memcmd() {
    avail=$(sysctl -n hw.physmem)
    used=$(vmstat -H | tail -1 | awk '{print $5}')
    RATIO=$(bc -l <<< "$used/$avail*100")
    printf '%3.1f' $RATIO
    echo %
  }
  loadcmd() {
    uptime | rev | cut -d' ' -f '1-3' | rev
  }
  cpucmd() {
    sysctl -n hw.ncpu
  }
else
  # assume linux
  memcmd() {
    free | awk '/Mem/{PERC=$NF/$2*100.0; printf "%3.1f%\n", PERC}'
  }
  loadcmd() {
    cut -d' ' -f '1-3' /proc/loadavg
  }
  cpucmd() {
    grep -cE '^processor' /proc/cpuinfo
  }
fi

case $1 in
  load)
    loadcmd
    ;;
  memory|mem)
    memcmd
    ;;
  cpu|cpucount)
    cpucmd
    ;;
esac
