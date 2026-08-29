-- ██╗  ██╗ █████╗  ██████╗ ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
-- ██║ ██╔╝██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
-- █████╔╝ ███████║██║   ██║███████╗███████║██████╔╝██║     ███████║
-- ██╔═██╗ ██╔══██║██║   ██║╚════██║██╔══██║██╔══██╗██║     ██╔══██║
-- ██║  ██╗██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╗██║  ██║
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local suppressMaximizeRule = hl.window_rule {
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = 'suppress-maximize-events',
    match = { class = '.*' },

    suppress_event = 'maximize',
}
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule {
    -- Fix some dragging issues with XWayland
    name = 'fix-xwayland-drags',
    match = {
        class = '^$',
        title = '^$',
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
}

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule {
    name = 'move-hyprland-run',
    match = { class = 'hyprland-run' },

    move = '20 monitor_h-120',
    float = true,
}

------------------------------------
---- APP -> WORKSPACE ASSIGNMENT ----
------------------------------------
-- All workspaces 1-9 are pinned to eDP-1 (the laptop screen) in monitors.lua,
-- so assigning a workspace here always lands the app on the laptop display.
-- Verify class names with `hyprctl clients -j` if an app doesn't land correctly.

hl.window_rule {
    name = 'firefox-workspace-1',
    match = { class = '(?i)^firefox$' },
    workspace = '1',
}

hl.window_rule {
    name = 'brave-workspace-2',
    match = { class = '(?i)^brave-browser$' },
    workspace = '2',
}

hl.window_rule {
    name = 'thunderbird-workspace-3',
    match = { class = '(?i)^org\\.mozilla\\.thunderbird$' },
    workspace = '3',
}

hl.window_rule {
    name = 'libreoffice-workspace-8',
    match = { class = '(?i)^libreoffice-.*$' },
    workspace = '8',
}

hl.window_rule {
    name = 'keepassxc-workspace-9',
    match = { class = '(?i)^(org\\.keepassxc\\.keepassxc|keepassxc)$' },
    workspace = '9',
}
