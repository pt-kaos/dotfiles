#!/bin/bash
# Confirmation in front of power actions so an accidental press doesn't end the
# session. "No" is preselected, so a reflexive Enter cancels.
#   powerconfirm.sh [poweroff|reboot|logout]   (default poweroff: SUPER+SHIFT+L unchanged)
action="${1:-poweroff}"
case "$action" in
poweroff) prompt='Power off?'; msg='Shutting down...'; post='systemctl poweroff' ;;
reboot)   prompt='Reboot?';    msg='Rebooting...';     post='systemctl reboot' ;;
logout)   prompt='Log out?';   msg='Logging out...';   post='' ;;
*) echo "usage: ${0##*/} [poweroff|reboot|logout]" >&2; exit 2 ;;
esac

answer=$(printf 'No\nYes\n' | rofi -dmenu -i -p "$prompt" -selected-row 0)
[ "$answer" = "Yes" ] || exit 0

if command -v hyprshutdown >/dev/null 2>&1; then
    if [ -n "$post" ]; then
        exec hyprshutdown -t "$msg" --post-cmd "$post"
    else
        exec hyprshutdown -t "$msg"
    fi
else
    [ -n "$post" ] && exec $post
    exec hyprctl dispatch exit
fi
