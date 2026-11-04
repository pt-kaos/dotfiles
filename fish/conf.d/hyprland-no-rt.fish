# Iris 2026-11-03: stop Hyprland 0.57 requesting realtime scheduling via rtkit.
# Crash hypothesis (silent SIGKILL by RLIMIT_RTTIME, Hyprland discussion #16648).
# Read by the Hyprland process at start, so it must be in the session login env.
# Remove this file (and re-login) to revert.
set -gx HYPRLAND_NO_RT 1
