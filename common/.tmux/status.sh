case $1 in
  load)
    uptime | awk -F': ' '{print $NF}'
    ;;
  unix)
    date +%s
    ;;
  disk)
    df -h | awk '/\/(home|mnt)/{print $NF": "$5}' | tr '\n' ' '
    ;;
esac
