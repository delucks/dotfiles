#!/bin/sh

# give me basic system stats for tmux statusline

case "$(uname)" in
  Darwin*)
    memcmd() {
      PAGESZ=$(sysctl -n hw.pagesize)
      FREE=$(( $(vm_stat | awk '/free/ {gsub(/\./, "", $3); print $3}') * PAGESZ))
      TOTAL=$(sysctl -n hw.memsize)
      RATIO=$(echo "$FREE/$TOTAL*100" | bc -l)
      printf '%3.1f' "$RATIO"
      echo %
    }
    loadcmd() {
      uptime | rev | cut -d' ' -f '1-3' | rev
    }
    cpucmd() {
      sysctl -n hw.ncpu
    }
  ;;
  Linux*)
    memcmd() {
      free | awk '/Mem/{PERC=$NF/$2*100.0; printf "%3.1f%\n", PERC}'
    }
    loadcmd() {
      cut -d' ' -f '1-3' /proc/loadavg
    }
    cpucmd() {
      nproc
    }
  ;;
  OpenBSD*)
    memcmd() {
      vmstat | tail -1 | while read -r _ _ act tot _; do
        used="${act%%M}"
        avail="${tot%%M}"
        RATIO=$(echo "$used/$avail*100" | bc -l)
        printf '%3.1f' "$RATIO"
      done
      echo %
    }
    loadcmd() {
      uptime | rev | cut -d' ' -f '1-3' | rev
    }
    cpucmd() {
      sysctl -n hw.ncpu
    }
  ;;
  FreeBSD*)
    # freebsd
    memcmd() {
      avail=$(sysctl -n hw.physmem)
      used=$(vmstat -H | tail -1 | awk '{print $5}')
      RATIO=$(echo "$used/$avail*100" | bc -l)
      printf '%3.1f' "$RATIO"
      echo %
    }
    loadcmd() {
      uptime | rev | cut -d' ' -f '1-3' | rev
    }
    cpucmd() {
      sysctl -n hw.ncpu
    }
  ;;
esac

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
