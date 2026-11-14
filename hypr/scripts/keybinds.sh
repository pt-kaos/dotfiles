#!/bin/bash
# Omarchy-style keybindings viewer (rofi). View-only. Bound to SUPER+K.
# Data: hyprctl -j binds (descriptions present, no keycodes, dispatcher opaque).
THEME="${KEYBINDS_THEME:-$HOME/.config/rofi/keybinds.rasi}"

rows() {
  hyprctl -j binds | jq -r '
    def mods: . as $m | [ (if ($m/64|floor)%2==1 then "SUPER" else empty end),
        (if ($m/4|floor)%2==1 then "CTRL" else empty end),
        (if ($m/8|floor)%2==1 then "ALT" else empty end),
        (if ($m/1|floor)%2==1 then "SHIFT" else empty end) ];
    def keyname:
      if . == "mouse:272" then "LEFT CLICK + DRAG" elif . == "mouse:273" then "RIGHT CLICK + DRAG"
      elif . == "mouse_down" then "SCROLL DOWN" elif . == "mouse_up" then "SCROLL UP"
      elif . == "slash" then "/" else ascii_upcase end;
    def prio: if (.description|test("Terminal|Launch Menu|Browser|Firefox|Brave|File Manager|Config|Lock|Shutdown|Close Window|Toggle Float|Scrachpad|Cheat|cheat|Keybindings")) then 0 else 1 end;
    [ .[] | select(.has_description)
      | { combo: ((.modmask|mods) + [.key|keyname] | join(" + ")), d: .description, p: prio } ]
    # collapse per-workspace rows
    | map(if (.d|test("^Workspace [0-9]+ \\(focused")) then .d="Workspace N (focused monitor)" | .combo=(.combo|sub("[0-9]$";"1..9")) elif (.d|test("^Send window to workspace [0-9]")) then .d="Send window to workspace N" | .combo=(.combo|sub("[0-9]$";"1..9")) else . end)
    | to_entries | map(.value + {i: .key})
    | reduce .[] as $r ({seen: {}, out: []}; if .seen[$r.combo + $r.d] then . else .seen[$r.combo + $r.d] = 1 | .out += [$r] end)
    | .out | sort_by([.p, .i]) | .[] | [.combo, .d] | @tsv' |
  awk -F'\t' '{ printf "%-30s → %s\n", $1, $2 }'
}

if [ "$1" = "--list" ]; then rows; exit; fi
rows | rofi -dmenu -i -no-custom -p "" -theme "$THEME" >/dev/null
