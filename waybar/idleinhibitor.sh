#!/bin/bash
# Status source for the waybar custom/idleinhibitor module.
# Truth = whether the hypridle daemon is running.
#   hypridle running     -> idle "active"    (auto lock / DPMS / suspend happen)
#   hypridle not running  -> idle "inhibited" (nothing sleeps; toggled via F12)
# Toggling is done by ~/.config/hypr/scripts/idle.sh (F12 keybind and the
# module's on-click), which also sends SIGRTMIN+9 to refresh this instantly.

if pgrep -x hypridle >/dev/null 2>&1; then
    printf '{"text":"","alt":"active","class":"active","tooltip":"Idle active — auto lock / DPMS / suspend enabled (F12 to inhibit)"}\n'
else
    printf '{"text":"","alt":"inhibited","class":"inhibited","tooltip":"Idle INHIBITED — no auto lock / DPMS / suspend (F12 to resume)"}\n'
fi
