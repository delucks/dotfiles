#!/usr/bin/env bash

# Poll the brightness on a Samsung Chromebook, raise and lower

SYSFILE="/sys/class/backlight/pwm-backlight.0/brightness"
CURRENT=$(cat $SYSFILE)

if [[ "$1" = "up" ]]; then
	RESULT=$(echo "$CURRENT + 100" | bc)
	if [[ $RESULT -gt 2700 ]]; then
		echo "2700" > $SYSFILE
	else
		echo "$RESULT" > $SYSFILE
	fi
else
	RESULT=$(echo "$CURRENT - 100" | bc)
	if [[ $RESULT -lt 100 ]]; then
		echo "100" > $SYSFILE
	else
		echo "$RESULT" > $SYSFILE
	fi
fi
