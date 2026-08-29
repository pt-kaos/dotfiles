#!/bin/bash
# Waybar module: pending pamac (repo + AUR) updates.
# pamac-tray's own icon can't register on a Wayland SNI tray (GtkStatusIcon-only
# build), so this polls the same source and renders as a custom waybar module.

mapfile -t updates < <(pamac checkupdates -q 2>/dev/null)
count=${#updates[@]}

if [ "$count" -eq 0 ]; then
    icon="󰸞"
    text=""
    class="updated"
    tooltip="System up to date"
else
    icon="󰚰"
    text="$count"
    class="pending"
    shown=("${updates[@]:0:15}")
    tooltip="$count update(s) available
$(printf '%s\n' "${shown[@]}")"
    if [ "$count" -gt 15 ]; then
        tooltip="$tooltip
… and $((count - 15)) more"
    fi
fi

jq -nc --arg text "$icon $text" --arg tooltip "$tooltip" --arg class "$class" \
    '{text: $text, tooltip: $tooltip, class: $class}'
