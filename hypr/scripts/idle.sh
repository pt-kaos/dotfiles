#!/bin/bash
if pgrep -x "hypridle" > /dev/null; then
    killall hypridle
    notify-send "Idle Mode" "Automatic standby disabled"
else
    hypridle &
    notify-send "Idle Mode" "Automatic standby enabled"
fi
