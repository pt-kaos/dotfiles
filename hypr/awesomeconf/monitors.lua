-- ██╗  ██╗ █████╗  ██████╗ ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
-- ██║ ██╔╝██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
-- █████╔╝ ███████║██║   ██║███████╗███████║██████╔╝██║     ███████║
-- ██╔═██╗ ██╔══██║██║   ██║╚════██║██╔══██║██╔══██╗██║     ██╔══██║
-- ██║  ██╗██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╗██║  ██║
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor {
    output = 'eDP-1',
    mode = 'preferred',
    position = '0x0',
    scale = '1',
}

hl.monitor {
    output = '',
    mode = 'preferred',
    position = 'auto',
    scale = '1',
}

------------------------------------------------
---- PER-MONITOR WORKSPACES (AwesomeWM tags) ---
------------------------------------------------
WS_PER_MON = 9 -- tags per monitor
WS_BLOCK = 10 -- ID stride between monitors (must be > WS_PER_MON)

-- Monitors listed here get blocks 0,1,2... in this order (stable across replug).
-- Anything not listed falls back to its Hyprland id.
local WS_MON_ORDER = { 'eDP-1', 'HDMI-A-1' }

function ws_block_of(mon) -- global: also used in keybindings.lua
    if not mon then
        return 0
    end
    for i, name in ipairs(WS_MON_ORDER) do
        if name == mon.name then
            return i - 1
        end
    end
    return mon.id
end

function ws_base_of(mon)
    return ws_block_of(mon) * WS_BLOCK
end

local function make_ws_rules(mon)
    local base = ws_base_of(mon)
    for i = 1, WS_PER_MON do
        hl.workspace_rule {
            workspace = tostring(base + i),
            monitor = mon.name,
            persistent = true,
            default = (i == 1),
        }
    end
end

for _, mon in ipairs(hl.get_monitors()) do
    make_ws_rules(mon)
end
hl.on('monitor.added', function(mon)
    make_ws_rules(mon)
end)

------------------------------------------------
---- FOLD WINDOWS BACK WHEN A MONITOR LEAVES ---
------------------------------------------------
-- When a secondary monitor is unplugged, move its windows onto the primary
-- monitor instead of leaving them stranded on now-hidden workspaces:
--   * A window whose class has a preferred workspace (mirrors the app->workspace
--     rules in windowrules.lua) returns to THAT workspace on the primary monitor.
--       e.g. Brave on secondary ws 5 (id 15) -> primary ws 2
--   * Any other window keeps its slot: secondary ws N -> primary ws N.
--       e.g. a terminal on secondary ws 6 (id 16) -> primary ws 6
--
-- Keep this list in sync with the class assignments in windowrules.lua.
-- Values are the LOCAL workspace index (1..WS_PER_MON) on the primary monitor.
local PREFERRED_WS = {
    { match = 'firefox', ws = 1 },
    { match = 'brave-browser', ws = 2 },
    { match = 'thunderbird', ws = 3 },
    { match = 'libreoffice', ws = 8 },
    { match = 'keepassxc', ws = 9 },
}

local PRIMARY_MON = WS_MON_ORDER[1]

local function preferred_ws_for(class)
    if not class then
        return nil
    end
    local c = class:lower()
    for _, rule in ipairs(PREFERRED_WS) do
        if c:find(rule.match, 1, true) then
            return rule.ws
        end
    end
    return nil
end

local function consolidate_onto_primary(removed_name, removed_base)
    -- Pick the surviving primary monitor (fall back to whatever is left).
    local target
    for _, m in ipairs(hl.get_monitors()) do
        if m.name == PRIMARY_MON then
            target = m
        end
    end
    target = target or hl.get_monitors()[1]
    if not target or target.name == removed_name then
        return
    end

    local target_base = ws_base_of(target)
    local lo, hi = removed_base + 1, removed_base + WS_PER_MON

    for _, win in ipairs(hl.get_windows()) do
        local ws = win.workspace
        if ws and ws.id >= lo and ws.id <= hi then
            local local_idx = ws.id - removed_base
            local dest_idx = preferred_ws_for(win.class) or local_idx
            hl.dispatch(hl.dsp.window.move {
                window = win,
                workspace = target_base + dest_idx,
                follow = false, -- move silently, don't chase focus per window
            })
        end
    end
end

hl.on('monitor.removed', function(mon)
    -- Read the monitor's identity now, while the object is still valid, then
    -- defer the actual moves so Hyprland finishes its own teardown first.
    local removed_name = mon and mon.name
    local removed_base = ws_base_of(mon)
    hl.timer(function()
        consolidate_onto_primary(removed_name, removed_base)
    end, { timeout = 200, type = 'oneshot' })
end)

--package.path = package.path .. ';../plugins/split-monitor-workspaces/lua/?.lua'
--local smw = require 'split-monitor-workspaces'

----- Required setup call with your custom configuration.
--hl.config{{
--    plugin['split-monitor-workspaces'] = {
--        workspace_count = 9
--        keep_focused = true,
--        enable_persistent_workspaces = true,
--        enable_notifications = false,
--    }
--})

function setup_smw()
    if hl.plugin['split-monitor-workspaces'] ~= nil then
        hl.plugin.load {
            'split-monitor-workspaces',
        }
        config {
            workspace_count = 9,
            keep_focused = true,
            enable_persistent_workspaces = true,
            enable_notifications = false,
        }
    end
end

setup_smw()
--hl.config {
--    plugin = {
--        split-monitor-workspaces = {
--            workspace_count = 9,
--            keep_focused = true,
--            enable_persistent_workspaces = true,
--            enable_notifications = false,
--        },
--    },
--}
--smw.setup {
--- Number of workspaces assigned to each monitor.
--   workspace_count = 9,

--- Monitor priority order: determines which monitor gets the lowest workspace IDs.
--- Monitors not listed are assigned priorities in the order Hyprland reports them.
--  monitor_priority = { 'eDP-1', 'HDMI-A-1' },

--- Per-monitor workspace count overrides (optional).
--- Monitors not listed fall back to workspace_count.
-- max_workspaces = { ["DP-2"] = 3 }, -- DP-2 gets only 3 workspaces, DP-1 is not overridden and gets 5.

--- Keep the currently focused workspace when the config is reloaded (recommended).
-- keep_focused = true,

--- Show a Hyprland notification on init and remap.
-- enable_notifications = false,

--- Keep workspaces alive even when empty.
--    enable_persistent_workspaces = true,

--- Wrap around when cycling past the first or last workspace.
--    enable_wrapping = true,

--- Switch all monitors simultaneously when changing workspaces (Gnome-style).
-- link_monitors = false,
--}

--- `get_amount_of_workspaces` is an easy helper function that simply returns the workspace_count you passed to the setup function.
--local mainMod = 'SUPER'
--for i = 1, smw.get_amount_of_workspaces() do
--    local n = tostring(i)
--    if n == '10' then
--        n = '0'
--    end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
--    -- Switch to the Nth workspace on the currently focused monitor.
--    hl.bind(mainMod .. ' +' .. n, smw.workspace(n))
--    -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
--    hl.bind(mainMod .. ' + SHIFT +' .. n, smw.move_to_workspace_silent(n))
--end
--
----- Cycle workspaces on the current monitor.
----- Accepts "next", "prev", "+N", or "-N" (e.g. "+2" skips two workspaces at once. why would you want to do that? idk but you can).
--hl.bind(mainMod .. ' + mouse_down', smw.cycle_workspaces 'next')
--hl.bind(mainMod .. ' + mouse_up', smw.cycle_workspaces 'prev')
--
----- Relative workspace switching using workspace().
----- "+N" / "-N" jump N workspaces forward/backward from the currently active one.
----- Wrapping behaviour follows the enable_wrapping config option.
--hl.bind(mainMod .. ' + PAGE_UP', smw.workspace '+1') -- Next workspace (relative).
--hl.bind(mainMod .. ' + PAGE_DOWN', smw.workspace '-1') -- Previous workspace (relative).
--
----- "empty" workspace: switch to the first empty workspace on the current monitor.
----- It can also be used as an argument with move_to_workspace(_silent) to move windows to the first empty workspace on the monitor.
----- Falls back to the last workspace in the monitor's range if all are occupied.
----hl.bind(mainMod .. " + E", smw.workspace("empty"))
----hl.bind(mainMod .. " + SHIFT + E", smw.move_to_workspace("empty"))
--
----- Move orphaned windows (not assigned to any mapped workspace) to the current workspace.
--hl.bind(mainMod .. ' + SHIFT + G', smw.grab_rogue_windows())
