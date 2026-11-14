#!/bin/bash
# Searchable cheat-sheet of the live Hyprland binds (hyprctl binds -j) in rofi.
# Bound to SUPER+slash. Selecting an entry only closes the menu.

hyprctl -j binds | jq -r '
  def mods: . as $m
    | [ (if ($m/64|floor)%2==1 then "Super" else empty end),
        (if ($m/4|floor)%2==1 then "Ctrl" else empty end),
        (if ($m/8|floor)%2==1 then "Alt" else empty end),
        (if ($m/1|floor)%2==1 then "Shift" else empty end) ];
  def keyname:
    if . == "mouse:272" then "LeftClick+drag"
    elif . == "mouse:273" then "RightClick+drag"
    elif . == "mouse_down" then "ScrollDown"
    elif . == "mouse_up" then "ScrollUp"
    elif . == "RETURN" then "Enter"
    elif . == "ESCAPE" then "Esc"
    elif . == "slash" then "/"
    elif (. | length) == 1 then ascii_upcase
    else . end;
  .[]
  | ((.modmask | mods) + [.key | keyname] | join(" + ")) as $combo
  | [$combo, (if .has_description then .description else "(no description)" end)]
  | "\(.[0] + "                              " | .[0:30])\(.[1])"
' | rofi -dmenu -i -p 'Keys' -no-custom -theme-str 'window {width: 60%;}' >/dev/null
