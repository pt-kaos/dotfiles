#!/bin/bash
# Confirmation in front of the SUPER+SHIFT+L bind so an accidental press
# doesn't kill the session. "No" is preselected, so a reflexive Enter cancels.

answer=$(printf 'No\nYes\n' | rofi -dmenu -i -p 'Power off?' -selected-row 0)
[ "$answer" = "Yes" ] || exit 0

if command -v hyprshutdown >/dev/null 2>&1; then
    exec hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff'
else
    exec systemctl poweroff
fi
