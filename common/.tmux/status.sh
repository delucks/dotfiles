case $1 in
  load)
    cut -d\  -f 1-3 /proc/loadavg
    ;;
  unix)
    date +%s
    ;;
  memory|mem)
    free | awk '/Mem/{PERC=$NF/$2*100.0; printf "%3.1f%\n", PERC}'
    ;;
esac
