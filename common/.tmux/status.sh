#!/usr/bin/env bash

# give me basic system stats for tmux statusline

case "$(uname)" in
  Darwin*)
    loadcmd() {
      uptime | rev | cut -d' ' -f '1-3' | rev
    }
    cpucmd() {
      sysctl -n hw.ncpu
    }
  ;;
  Linux*)
    loadcmd() {
      cut -d' ' -f '1-3' /proc/loadavg
    }
    cpucmd() {
      nproc
    }
  ;;
  OpenBSD*)
    loadcmd() {
      sysctl -n vm.loadavg
    }
    cpucmd() {
      sysctl -n hw.ncpu
    }
  ;;
  FreeBSD*)
    loadcmd() {
      uptime | rev | cut -d' ' -f '1-3' | rev
    }
    cpucmd() {
      sysctl -n hw.ncpu
    }
  ;;
  SunOS*)
    loadcmd() {
      uptime | awk -F'average: ' '{print $2}'
    }
    cpucmd() {
      psrinfo -p
    }
  ;;
esac

case $1 in
  load)
    loadcmd
    ;;
  cpu|cpucount)
    cpucmd
    ;;
esac
