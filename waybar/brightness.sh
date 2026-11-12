#!/usr/bin/env bash
# Unified brightness control: internal panel (backlight) + external monitors (DDC/CI).
#
#   brightness.sh get  [<connector>]          -> print JSON for a waybar custom module
#   brightness.sh up   [<step>] [<connector>] -> raise brightness
#   brightness.sh down [<step>] [<connector>] -> lower brightness
#
# With no <connector>, up/down act on the currently focused Hyprland monitor, so a
# single keybinding drives whichever screen has focus. The waybar module passes an
# explicit connector so each bar always shows/controls its own output.
#
# eDP-1 (laptop panel) goes through brightnessctl; anything else goes through
# ddcutil over the i2c bus behind that DRM connector. DDC/CI needs membership in
# the "i2c" group (udev rule ships with the ddcutil package) or root.
set -euo pipefail

WAYBAR_SIGNAL=10   # must match "signal" in the custom/brightness module
STEP_DEFAULT=5
INTERNAL="eDP-1"

focused_monitor() {
    hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
}

# connector name -> i2c bus number (empty if the connector has no DDC channel)
ddc_bus_for() {
    local p
    for p in /sys/class/drm/card*-"$1"/ddc/i2c-dev/i2c-*; do
        [ -e "$p" ] && { basename "$p" | sed 's/^i2c-//'; return; }
    done
}

# Guard against a monitor that is not ready (resume, HDMI hotplug): ddcutil would
# burn its retries and log DDCRC_RETRIES to the journal on every 5 s poll. So:
#  - skip ddcutil unless the connector reports "connected"
#  - after a failed read, skip ddcutil for DDC_COOLDOWN seconds
#  - while skipping, show the last good value (cached), else 0 with a tooltip note
STATE_DIR=${XDG_RUNTIME_DIR:-/tmp}
DDC_COOLDOWN=45

connector_ready() {
    local p
    for p in /sys/class/drm/card*-"$1"/status; do
        [ -r "$p" ] && [ "$(cat "$p")" = connected ] && return 0
    done
    return 1
}

# external read with cache + cooldown; prints "<pct>" or "<pct> stale" when not live
get_pct_ddc() {
    local conn=$1 bus stamp="$STATE_DIR/brightness-$1.fail" cache="$STATE_DIR/brightness-$1.val" v now last
    now=$(date +%s)
    last=$(cat "$stamp" 2>/dev/null || echo 0)
    bus=$(ddc_bus_for "$conn")
    if [ -n "$bus" ] && connector_ready "$conn" && [ $((now - last)) -ge "$DDC_COOLDOWN" ]; then
        v=$(ddcutil --bus "$bus" --brief --sleep-multiplier 0.3 getvcp 10 2>/dev/null \
            | awk '{print $4}') || v=""
        if [[ "$v" =~ ^[0-9]+$ ]]; then
            rm -f "$stamp"
            echo "$v" >"$cache"
            echo "$v"
            return
        fi
        echo "$now" >"$stamp"
    fi
    echo "$(cat "$cache" 2>/dev/null || echo 0) stale"
}

get_pct() {
    local conn=$1
    if [ "$conn" = "$INTERNAL" ]; then
        brightnessctl -m | cut -d, -f4 | tr -d '%'
    else
        get_pct_ddc "$conn"
    fi
}

adjust() {
    local conn=$1 dir=$2 step=$3 bus
    if [ "$conn" = "$INTERNAL" ]; then
        brightnessctl -e4 -n2 set "${step}%${dir}" >/dev/null
    else
        bus=$(ddc_bus_for "$conn")
        [ -n "$bus" ] || exit 0
        ddcutil --bus "$bus" --noverify --sleep-multiplier 0.3 setvcp 10 "$dir" "$step"
        rm -f "$STATE_DIR/brightness-$conn.fail"   # a working write ends any cooldown
    fi
}

case "${1:-get}" in
    get)
        conn=${2:-$(focused_monitor)}
        read -r pct stale <<<"$(get_pct "$conn")"
        note=""; [ -n "${stale:-}" ] && note=" (monitor not ready, last known)"
        printf '{"percentage":%s,"tooltip":"%s: %s%%%s"}\n' "${pct:-0}" "$conn" "${pct:-0}" "$note"
        ;;
    up|down)
        [ "$1" = up ] && dir=+ || dir=-
        step=${2:-$STEP_DEFAULT}
        conn=${3:-$(focused_monitor)}
        adjust "$conn" "$dir" "$step"
        pkill -RTMIN+$WAYBAR_SIGNAL waybar 2>/dev/null || true
        ;;
    *)
        echo "usage: brightness.sh get|up|down [step] [connector]" >&2
        exit 2
        ;;
esac
