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

get_pct() {
    local conn=$1 bus
    if [ "$conn" = "$INTERNAL" ]; then
        brightnessctl -m | cut -d, -f4 | tr -d '%'
    else
        bus=$(ddc_bus_for "$conn")
        if [ -n "$bus" ]; then
            ddcutil --bus "$bus" --brief --sleep-multiplier 0.3 getvcp 10 2>/dev/null \
                | awk '{print $4}'
        else
            echo 0
        fi
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
    fi
}

case "${1:-get}" in
    get)
        conn=${2:-$(focused_monitor)}
        pct=$(get_pct "$conn")
        printf '{"percentage":%s,"tooltip":"%s: %s%%"}\n' "${pct:-0}" "$conn" "${pct:-0}"
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
