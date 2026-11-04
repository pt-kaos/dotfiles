#!/bin/bash
# Wayland screenshots for the Print binds (see awesomeconf/keybindings.lua).
#   region       slurp region -> clipboard
#   region-save  slurp region -> ~/Pictures/Screenshots + clipboard
#   full-save    focused monitor -> ~/Pictures/Screenshots + clipboard
#   annotate     flameshot gui
# No notification: the running notifier (xfce4-notifyd) does not show on Hyprland.

dir="$HOME/Pictures/Screenshots"
file="$dir/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"

save_and_copy() { # args: grim args...
    mkdir -p "$dir" || exit 1
    grim "$@" "$file" && wl-copy --type image/png <"$file"
}

case "$1" in
region)
    geom=$(slurp) || exit 0
    [ -n "$geom" ] || exit 0
    grim -g "$geom" - | wl-copy --type image/png
    ;;
region-save)
    geom=$(slurp) || exit 0
    [ -n "$geom" ] || exit 0
    save_and_copy -g "$geom"
    ;;
full-save)
    out=$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')
    [ -n "$out" ] || exit 1
    save_and_copy -o "$out"
    ;;
annotate)
    exec flameshot gui
    ;;
*)
    echo "usage: ${0##*/} region|region-save|full-save|annotate" >&2
    exit 2
    ;;
esac
