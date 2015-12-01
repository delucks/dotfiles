uptime | awk -F':' '{print $NF}' | sed 's/^\ //g'
