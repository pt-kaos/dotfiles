# ─────────────────────────────────────────────────────────────────────────────
#  THEME — single source of truth.
#  Edit values here, then run:  ~/.config/theme/apply.sh
#  Colours keep the leading '#' (so editors show a swatch); apply.sh strips it
#  and adds whatever prefix each app wants.
# ─────────────────────────────────────────────────────────────────────────────

# --- core palette (matches the waybar design: one moss-green accent) ----------
BG='#12140f'          # base background
BG_ALPHA='0.78'       # bar / overlay translucency (waybar bar background)
BG_ALT='#1a1c17'      # raised surface (capsules, input fields)
FG='#d3d7d1'          # primary text
FG_DIM='#8b978a'      # muted text / disabled
ACCENT='#8fae6f'      # THE accent — moss green, used sparingly
ACCENT_DIM='#607850'  # accent, recessed (selections, second gradient stop)
WARNING='#e0a458'     # discrete orange — only when a module enters that state
CRITICAL='#e05c5c'    # red — errors / critical

# --- window borders ----------------------------------------------------------
BORDER_ACTIVE_A="$ACCENT"      # focused border gradient, stop 1
BORDER_ACTIVE_B="$ACCENT_DIM"  # focused border gradient, stop 2
BORDER_INACTIVE='#595959'      # unfocused border

# --- terminal ANSI 8 (blue/magenta/cyan kept tasteful, rest come from core) ---
ANSI_BLUE='#6a90b0'
ANSI_MAGENTA='#a98fb0'
ANSI_CYAN='#7fb0a8'

# --- application theme names (not colours) ----------------------------------- -
GTK_THEME='Adwaita-dark'          # works for GTK3 AND GTK4 (Arc-Dark is GTK3-only)
ICON_THEME='Papirus-Dark'
CURSOR_THEME='Bibata-Modern-Ice'
CURSOR_SIZE='24'
FONT_NAME='Noto Sans 11'
KVANTUM_THEME='KvGnomeDark'       # dark Kvantum theme to pair with Adwaita-dark
