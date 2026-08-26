# AwesomeWM Configuration Agent Guidelines

This document provides guidelines for AI agents interacting with this AwesomeWM configuration.

## Build, Lint, and Test

- **Build**: No build step. The configuration is loaded by the `awesome` executable.
- **Reload**: To apply changes, restart AwesomeWM (usually with `Mod + r`).
- **Lint**: No linter is configured. Follow existing code style.
- **Test**: No test suite. Changes are tested by using the window manager. A single test can be run by reloading the configuration and observing the behavior.

## Code Style

- **Language**: Lua
- **Formatting**:
  - Indentation: Use 2 spaces.
  - Comments: Use `--` for single-line comments.
  - Structure: Use `{{{` and `}}}` to mark code sections for folding.
- **Naming Conventions**:
  - Variables and functions: `snake_case`.
- **Imports**: Use `require("module")` to load modules.
- **Error Handling**: Errors are displayed as notifications using the `naughty` library. Ensure error signals are handled properly.
- **File Organization**:
  - `rc.lua`: Main configuration file.
  - `themes/`: Theme definitions.
  - `main/`: Core configuration files.
  - `keys/`: Keybindings.
  - `lain/`: Third-party library.
