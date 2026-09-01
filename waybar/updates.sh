#!/bin/bash
# Waybar module: pending updates (official + chaotic repos, then AUR).
# pamac-tray's own icon can't register on a Wayland SNI tray (GtkStatusIcon-only
# build), so this polls the same source and renders as a custom waybar module.
#
# Uses pacman-contrib `checkupdates`, NOT `pamac checkupdates`: pamac compares
# against its own unprivileged DB copy in /var/tmp/pamac/dbs, which only refreshes
# when pamac-daemon is running (it isn't, headless) or RefreshPeriod (6h, see
# /etc/pamac.conf) lapses — so it kept reporting "up to date" for days. Instead,
# `checkupdates` keeps its own DB in /tmp/checkup-db-$UID and does a real
# `pacman -Sy` into it every call; `paru -Qua` adds true AUR packages.

mapfile -t updates < <( { checkupdates 2>/dev/null; paru -Qua 2>/dev/null; } | sort -u )
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
