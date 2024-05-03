#!/usr/bin/env bash

LOG_FILE=/tmp/polybar_bottom.log

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do
	sleep 1
done

MONITORS="$(xrandr --query | grep """ connected""" | cut -d""" """ -f1)"

echo "---" > $LOG_FILE

for m in $MONITORS; do
	echo "date: $(date)" >> $LOG_FILE
	echo "monitor: $m" >> $LOG_FILE
	MONITOR="$m" polybar bottom 2>&1 | tee -a $LOG_FILE & disown
done
