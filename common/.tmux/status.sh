#!/usr/bin/env bash

# give me basic system stats for tmux statusline

if [[ "$OSTYPE" == "darwin"* ]]
then
  memcmd() {
    PAGESZ=$(sysctl -n hw.pagesize)
    FREE=$(( $(vm_stat | awk '/free/ {gsub(/\./, "", $3); print $3}') * PAGESZ))
    TOTAL=$(sysctl -n hw.memsize)
    RATIO=$(bc -l <<< "$FREE/$TOTAL*100")
    printf '%3.1f' "$RATIO"
    echo %
  }
  loadcmd() {
    uptime | rev | cut -d' ' -f '1-3' | rev
  }
  cpucmd() {
    sysctl -n hw.ncpu
  }
elif [[ "$OSTYPE" == "linux"* ]]
then
  memcmd() {
    free | awk '/Mem/{PERC=$NF/$2*100.0; printf "%3.1f%\n", PERC}'
  }
  loadcmd() {
    cut -d' ' -f '1-3' /proc/loadavg
  }
  cpucmd() {
    grep -cE '^processor' /proc/cpuinfo
  }
else
  # assume bsd
  if [[ "$OSTYPE" == "openbsd"* ]]
  then
    memcmd() {
      vmstat | tail -1 | while read -sr _ _ act tot _; do
        used="${act//M/}"
        avail="${tot//M/}"
        RATIO=$(bc -l <<< "$used/$avail*100")
        printf '%3.1f' "$RATIO"
      done
      echo %
    }
  else
    # freebsd
    memcmd() {
      avail=$(sysctl -n hw.physmem)
      used=$(vmstat -H | tail -1 | awk '{print $5}')
      RATIO=$(bc -l <<< "$used/$avail*100")
      printf '%3.1f' "$RATIO"
      echo %
    }
  fi
  loadcmd() {
    uptime | rev | cut -d' ' -f '1-3' | rev
  }
  cpucmd() {
    sysctl -n hw.ncpu
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
