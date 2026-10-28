-- ██╗  ██╗ █████╗  ██████╗ ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
-- ██║ ██╔╝██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
-- █████╔╝ ███████║██║   ██║███████╗███████║██████╔╝██║     ███████║
-- ██╔═██╗ ██╔══██║██║   ██║╚════██║██╔══██║██╔══██╗██║     ██╔══██║
-- ██║  ██╗██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╗██║  ██║
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
---------------
---- INPUT ----
---------------
hl.config {
    input = {
        kb_layout = 'pt',
        kb_variant = '',
        kb_model = '',
        kb_options = '',
        kb_rules = '',
        numlock_by_default = true,

        follow_mouse = 0,
        -- Without this, floating windows still grab focus on hover (and drop it
        -- when the pointer leaves), ignoring follow_mouse = 0. 0 = focus only
        -- changes on click or keyboard, for floating and tiled alike.
        float_switch_override_focus = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },
}

hl.gesture {
    fingers = 3,
    direction = 'horizontal',
    action = 'workspace',
}

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device {
    name = 'epic-mouse-v1',
    sensitivity = -0.5,
}
