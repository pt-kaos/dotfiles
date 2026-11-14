#!/bin/bash
# kaos-menu: Omarchy-style hierarchical root menu (rofi) + app launcher.
#   kaos-menu.sh            root menu   (SUPER+SPACE)
#   kaos-menu.sh apps       app launcher (SUPER+ALT+SPACE), rofi drun
#   kaos-menu.sh --list L   print level L (debug);  --dry: print action instead of running
# Esc goes up one level (closes at root). Type to filter at every level.
THEME="${KAOS_MENU_THEME:-$HOME/.config/rofi/menu.rasi}"
HYPR="$HOME/.config/hypr"
DOT="$HOME/Documents/DotFiles"
TERM_CMD="alacritty -e"
DRY=0
[ "$1" = "--dry" ] && { DRY=1; shift; }

edit() { printf '%s nvim %q' "$TERM_CMD" "$1"; }

# Each line: "<icon>  <label>\t<action>"; action = menu:<level> or a shell command.
level() {
  local t=$'\t'
  case "$1" in
  root)
    printf '%s\n' \
      "󰀻  Apps${t}apps" \
      "󰄀  Capture${t}menu:capture" \
      "󰏘  Style${t}menu:style" \
      "󱓞  Toggle${t}menu:toggle" \
      "󰒓  Setup${t}menu:setup" \
      "󰧑  Learn${t}menu:learn" \
      "󰐥  System${t}menu:system" ;;
  capture)
    printf '%s\n' \
      "󰆞  Region to clipboard${t}$HYPR/scripts/screenshot.sh region" \
      "󰆓  Region, save + clipboard${t}$HYPR/scripts/screenshot.sh region-save" \
      "󰍹  Screen, save + clipboard${t}$HYPR/scripts/screenshot.sh full-save" \
      "󰏫  Annotate (flameshot)${t}$HYPR/scripts/screenshot.sh annotate" \
      "󰈊  Color picker${t}hyprpicker -a" \
      "󰉋  Open Screenshots folder${t}thunar $HOME/Pictures/Screenshots" ;;
  style)
    printf '%s\n' \
      "󰏘  Re-apply theme (palette.sh)${t}$DOT/theme/apply.sh" \
      "󰏫  Edit palette${t}$(edit "$DOT/theme/palette.sh")" \
      "󰸉  Backgrounds folder${t}thunar $DOT/Backgrounds" \
      "󰍜  Restart Waybar${t}sh -c 'pkill -x waybar; setsid waybar >/dev/null 2>&1 &'" ;;
  toggle)
    printf '%s\n' \
      "󰒲  Idle lock / suspend${t}$HYPR/scripts/idle.sh" \
      "󰍜  Waybar visibility${t}pkill -SIGUSR1 waybar" \
      "󰖔  Nightlight (hyprsunset)${t}sh -c 'pkill -x hyprsunset || setsid hyprsunset -t 4000 >/dev/null 2>&1 &'" ;;
  setup)
    printf '%s\n' \
      "󰕾  Audio (pavucontrol)${t}pavucontrol" \
      "󰖩  Wi-Fi (nmtui)${t}$TERM_CMD nmtui" \
      "󰂯  Bluetooth (bluetoothctl)${t}$TERM_CMD bluetoothctl" \
      "󰍹  Monitors config${t}$(edit "$HYPR/awesomeconf/monitors.lua")" \
      "󰈙  Config files${t}menu:config" \
      "󰑓  Reload Hyprland${t}hyprctl reload" ;;
  config)
    printf '%s\n' \
      "󰖲  Hyprland${t}$(edit "$HYPR/hyprland.lua")" \
      "󰌌  Keybindings${t}$(edit "$HYPR/awesomeconf/keybindings.lua")" \
      "󰍜  Waybar${t}$(edit "$HOME/.config/waybar/config.jsonc")" \
      "󰏘  Theme palette${t}$(edit "$DOT/theme/palette.sh")" \
      "󰒲  Hypridle${t}$(edit "$HYPR/hypridle.conf")" \
      "󰌾  Hyprlock${t}$(edit "$HYPR/hyprlock.conf")" \
      "󰸉  Hyprpaper${t}$(edit "$HYPR/hyprpaper.conf")" \
      "󰆍  Alacritty${t}$(edit "$HOME/.config/alacritty/alacritty.toml")" \
      "󰈺  Fish${t}$(edit "$HOME/.config/fish/config.fish")" \
      "󰈔  Neovim${t}$(edit "$HOME/.config/nvim/init.lua")" ;;
  learn)
    printf '%s\n' \
      "󰌌  Keybindings${t}$HYPR/scripts/keybinds.sh" \
      "󰖟  Hyprland wiki${t}xdg-open https://wiki.hypr.land" \
      "󰣇  Arch wiki${t}xdg-open https://wiki.archlinux.org" \
      "󰖟  Neovim docs${t}xdg-open https://neovim.io/doc/user/" ;;
  system)
    printf '%s\n' \
      "󰌾  Lock${t}hyprlock" \
      "󰍃  Log out${t}$HYPR/scripts/powerconfirm.sh logout" \
      "󰜉  Reboot${t}$HYPR/scripts/powerconfirm.sh reboot" \
      "󰐥  Shutdown${t}$HYPR/scripts/powerconfirm.sh poweroff" \
      "󰓅  Monitor (btop)${t}$TERM_CMD btop" ;;
  esac
}

if [ "$1" = "--list" ]; then level "${2:-root}"; exit; fi

run() { # action
  if [ "$DRY" = 1 ]; then echo "$1"; else setsid sh -c "$1" >/dev/null 2>&1 </dev/null & fi
}

launcher() {
  exec rofi -show drun -show-icons -theme "$THEME" \
    -theme-str 'entry { placeholder: "Apps…"; } listview { lines: 9; }' \
    -drun-display-format '{name}'
}

[ "$1" = "apps" ] && launcher

stack=(root)
[ -n "$KAOS_MENU_START" ] && stack+=("$KAOS_MENU_START")  # debug / mockups
while [ ${#stack[@]} -gt 0 ]; do
  cur=${stack[-1]}
  mapfile -t lines < <(level "$cur")
  labels=$(printf '%s\n' "${lines[@]}" | cut -f1)
  crumb=root; for s in "${stack[@]:1}"; do crumb+=" › $s"; done
  idx=$(printf '%s\n' "$labels" | rofi -dmenu -i -no-custom -format i -p "" \
    -theme "$THEME" -theme-str "entry { placeholder: \"${crumb/root/Menu}…\"; }")
  rc=$?
  if [ $rc -ne 0 ] || [ -z "$idx" ]; then unset 'stack[-1]'; continue; fi
  act=${lines[$idx]#*$'\t'}
  case "$act" in
  menu:*) stack+=("${act#menu:}") ;;
  apps) launcher ;;
  *) run "$act"; exit 0 ;;
  esac
done
