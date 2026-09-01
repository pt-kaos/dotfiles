# theme/

Centralised colour theme for the dotfiles.

## Use

1. Edit **`palette.sh`** — the only file with real values.
2. Run **`./apply.sh`** (aliased in `~/.config/theme/`).

`apply.sh` regenerates every per-app colour file and reloads waybar + Hyprland.
New terminals, GTK and Qt windows pick the theme up on their next launch.
`apply.sh --boot` (run from Hyprland autostart) regenerates without reloading.

## What it drives

| Target | File written | Wiring |
|---|---|---|
| Waybar | `../waybar/colors.css` | `style.css` has `@import url("colors.css")` |
| Hyprland borders/shadow | `../hypr/awesomeconf/colors.lua` | `looknfeel.lua` does `require 'awesomeconf.colors'` |
| hyprlock | `../hypr/colors.conf` | `hyprlock.conf` has `source = ~/.config/hypr/colors.conf` |
| Alacritty | `../alacritty/colors.toml` | `alacritty.toml` has `[general] import` |
| fish | `../fish/conf.d/zz-theme.fish` | auto-loaded by fish (sorts last) |
| GTK 3 + 4 | `~/.config/gtk-3.0/settings.ini`, `gtk-4.0/settings.ini` | read by GTK directly |
| GTK4 / libadwaita / portal | `gsettings org.gnome.desktop.interface` | `color-scheme=prefer-dark` etc. |
| Qt | `~/.config/Kvantum/kvantum.kvconfig` | `QT_QPA_PLATFORMTHEME=qt5ct`, `QT_STYLE_OVERRIDE=kvantum` (set in Hyprland env) |

The GTK `settings.ini` / Kvantum / gsettings targets are real files outside the
repo; they are fully reproduced by `apply.sh`, so they don't need to be tracked.

## Notes

- hypridle has no colours of its own — nothing to theme there.
- Qt accent colour isn't templated (Kvantum themes are SVG, not a palette); we
  only pin a dark Kvantum theme name. Change `KVANTUM_THEME` in `palette.sh`.
- Generated files carry an "AUTO-GENERATED" header — edit `palette.sh`, not them.
