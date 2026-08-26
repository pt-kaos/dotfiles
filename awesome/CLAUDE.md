# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal AwesomeWM (Awesome Window Manager) configuration written in Lua. It customizes the desktop environment with keybindings, window rules, themes, and custom widgets. The configuration integrates the third-party `lain` library for additional widgets and layouts.

## Development Workflow

### Applying Changes
There is no build step. AwesomeWM loads the Lua files directly.

- **Reload Configuration**: Restart AwesomeWM with `Mod + r` (where Mod is typically the Super/Windows key)
- **Test Changes**: Changes are tested by reloading and observing behavior
- **No linter configured**: Follow existing code style conventions

### Code Style
- **Language**: Lua
- **Indentation**: 2 spaces (not tabs)
- **Comments**: Single-line with `--`, section markers with `{{{` and `}}}`
- **Naming**: Use `snake_case` for variables and functions
- **Module Loading**: Use `require("module")` syntax
- **Error Handling**: Errors display as notifications using the `naughty` library

## Architecture

### Entry Point
`rc.lua` is the main configuration file that orchestrates loading of all modules:
1. Loads core libraries (gears, awful, beautiful, naughty, freedesktop)
2. Requires custom modules from `main/`, `keys/`, and `utils/`
3. Initializes theme from `themes/` directory
4. Sets up menu, mouse bindings, and signals
5. Runs autostart scripts

### Core Configuration Files

**`main/` directory**:
- `myvariables.lua` - Global variables (modkey, applications, layouts, tagnames)
- `rules.lua` - Window placement rules defining which applications go to which tags, floating behavior, and maximization rules
- `signals.lua` - Event handlers including custom screen disconnection handling that preserves client tags when screens are removed/reconnected
- `error-handling.lua` - Error notification setup

**`keys/` directory**:
- `init.lua` - All keybindings for the WM
- Empty placeholder files for future organization: `appkeys.lua`, `layoutkeys.lua`, `mediakeys.lua`, `menukeys.lua`, `movekeys.lua`

**`utils/` directory**:
- `init.lua` - Utility functions (currently contains `dmenu_run_f` for dmenu styling)

### Theme System

**Theme Selection**: Currently using "kaos" theme (selected in `rc.lua` line 73)

**Theme Structure** (`themes/kaos/`):
- `theme.lua` - Main theme file defining colors, fonts, borders, menu styling, and widget icons
- Color palette includes named colors (redbrick, lightorange, darkcyan, etc.)
- Uses Hack font at 11pt
- Material Symbols Rounded icon font

**Widget System** (`themes/widgets/`):
- `init.lua` - Widget setup and wibar (status bar) construction
- Individual widget modules: `cal.lua`, `cpu.lua`, `mem.lua`, `bat.lua`, `vol.lua`, `time.lua`
- `widget_wrapper.lua` - Widget styling wrapper
- Widgets are assembled into the top wibar with taglist, tasklist, system tray, and custom widgets

### Third-Party Libraries

**lain** (`lain/` directory):
- Provides additional layouts, widgets, and utilities
- Used for quake terminal functionality (`lain.util.quake`)
- Imported with `require("lain")`

**freedesktop**:
- Used for menu generation
- Provides XDG-compliant application menu

### Key Configuration Details

**Modkeys**:
- `modkey` = Mod4 (Super/Windows key)
- `altkey` = Mod1 (Alt key)
- `modkey1` = Control

**Applications** (defined in `main/myvariables.lua`):
- Terminal: alacritty
- Editor: nvim/subl
- Browsers: firefox, brave, chromium
- File manager: thunar

**Tag Names**: Uses emoji icons for tags (defined in `main/myvariables.lua` line 25)

**Window Rules** (`main/rules.lua`):
- Applications automatically assigned to specific tags (e.g., Firefox → tag 1, Spotify → tag 9)
- Titlebars disabled by default
- Specific applications set to maximized or floating

### Autostart System

**`autostart.sh`**:
- Bash script that starts applications on login
- Uses custom `run()` function to check if process is already running before starting
- Starts system tray apps (nm-applet, pamac-tray, volumeicon, etc.)
- Also invoked from `rc.lua` line 120

**Compositor**: picom runs with custom config (`picom.conf`)

### Signal System

**Screen Management** (`main/signals.lua`):
- Custom screen disconnection handler that preserves client tags when external monitors are unplugged
- Clients track their `last_tag` property
- When screen is removed, clients are moved to corresponding tag on primary screen

**Client Management**:
- Automatic border width adjustment (single clients get thinner borders)
- Border colors change on focus/unfocus
- Minimized clients are forced to unminimize
- Wallpaper restoration on screen geometry changes

## Important Notes

- The configuration uses global variables (e.g., `beautiful`, `dpi`, `modkey`) that are set in various files
- `clientkeys` and `clientbuttons` are referenced in rules but defined in `keys/init.lua`
- Widget styling uses the `dpi()` function from beautiful.xresources for HiDPI support
- The wibar (status bar) has semi-transparent background using color alpha values (e.g., `'#313131' .. '20'`)
