# AwesomeWM Configuration

## Project Overview
This directory contains the personal configuration for Awesome Window Manager, written in Lua. It customizes the desktop environment, including keybindings, rules for windows, themes, and widgets. The configuration leverages several AwesomeWM core libraries (`gears`, `awful`, `beautiful`, `naughty`, `freedesktop`) and integrates the third-party `lain` library for additional widgets and layouts.

## Building and Running
There is no explicit build step for this configuration. AwesomeWM loads the Lua files directly.

*   **Applying Changes**: To apply any modifications to the configuration, restart AwesomeWM. This is typically done by pressing `Mod + r` (where `Mod` is usually the Super key or Windows key).
*   **Autostart Applications**: Applications that start automatically with AwesomeWM are configured in `autostart.sh` and through `awful.spawn.with_shell` calls within `rc.lua`.
*   **Main Configuration File**: The primary entry point for the configuration is `rc.lua`.

## Development Conventions
The following conventions are observed in this AwesomeWM configuration:

*   **Language**: Lua
*   **Formatting**:
    *   Indentation: Use 2 spaces.
    *   Comments: Use `--` for single-line comments.
    *   Code Folding: Sections are often marked with `{{{` and `}}}` for better readability and navigation.
*   **Naming Conventions**:
    *   Variables and functions: `snake_case`.
*   **Module Imports**: Modules are loaded using `require("module_name")`.
*   **Error Handling**: Errors and important messages are typically displayed as desktop notifications using the `naughty` library.
*   **File Organization**:
    *   `rc.lua`: The main configuration file, orchestrating the loading of other modules.
    *   `themes/`: Contains definitions for various themes, including custom widgets and styling.
    *   `main/`: Houses core configuration logic, such as `myvariables.lua` (global variables), `rules.lua` (window rules), `signals.lua` (event handling), and `error-handling.lua`.
    *   `keys/`: Defines all custom keybindings for applications, layouts, media, and menus.
    *   `lain/`: Integrates the `lain` library, providing additional widgets and layouts.
    *   `utils/`: Contains general utility functions.
    *   `_evil.bck/`, `_helpers.bck/`, `_signals.bck/`: Directories likely containing backup or helper modules for specific functionalities.
