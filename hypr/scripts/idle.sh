#!/bin/bash
# Toggle the hypridle daemon. Bound to F12 and to the waybar
# custom/idleinhibitor module's on-click, so both drive one shared state.
# After toggling, poke waybar (SIGRTMIN+9) so custom/idleinhibitor repaints
# immediately instead of waiting for its 5s poll.

if pgrep -x "hypridle" > /dev/null; then
    killall hypridle
    notify-send -a idle "Idle inhibited" "Auto lock / DPMS / suspend disabled"
else
    hypridle & disown
    notify-send -a idle "Idle active" "Auto lock / DPMS / suspend enabled"
fi

pkill -RTMIN+9 waybar 2>/dev/null || true
