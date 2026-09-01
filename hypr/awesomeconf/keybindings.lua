-- ██╗  ██╗ █████╗  ██████╗ ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
-- ██║ ██╔╝██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
-- █████╔╝ ███████║██║   ██║███████╗███████║██████╔╝██║     ███████║
-- ██╔═██╗ ██╔══██║██║   ██║╚════██║██╔══██║██╔══██╗██║     ██╔══██║
-- ██║  ██╗██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╗██║  ██║
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
---
-- default programs are in 'awesomeconf.myprograms'. These were imported in the hyprland.lua
---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = 'SUPER' -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- hl.bind(mainMod .. ' + Q', hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. ' + RETURN', hl.dsp.exec_cmd(terminal), { description = 'Launch Terminal' })
hl.bind(mainMod .. ' + SHIFT + RETURN', hl.dsp.exec_cmd(fileManager), { description = 'Launch File Manager' })
local closeWindowBind = hl.bind(mainMod .. ' + Q', hl.dsp.window.close(), { description = 'Close Window' })
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. ' + L', hl.dsp.exec_cmd 'pidof hyprlock || hyprlock --grace 15', { description = 'Lock Screen (15s grace: any key/mouse unlocks)' })
hl.bind(
    mainMod .. ' + SHIFT + L',
    hl.dsp.exec_cmd '~/.config/hypr/scripts/powerconfirm.sh',
    { description = 'Shutdown (with confirmation)' }
)
hl.bind(mainMod .. ' + E', hl.dsp.exec_cmd 'dm_configfiles', { description = 'Config Files' })
hl.bind(mainMod .. ' + F', hl.dsp.exec_cmd(fileManager), { description = 'File Manager' })
hl.bind(mainMod .. ' + F', hl.dsp.window.float { action = 'toggle' }, { description = 'Toggle Float' })
hl.bind(mainMod .. ' + R', hl.dsp.exec_cmd(menu), { description = 'Launch Menu' })
hl.bind(mainMod .. ' + P', hl.dsp.window.pseudo(), { description = 'Pseudo Window' })
hl.bind(mainMod .. ' + M', hl.dsp.layout 'swapwithmaster', { description = 'Swap With Master Window' }) -- dwindle only
hl.bind(mainMod .. ' + Z', hl.dsp.exec_cmd(terminal .. ' -e xdg-open $(fzf)'), { description = 'FZF Search file & open' })
hl.bind(mainMod .. ' + C', function()
    hl.dispatch(hl.dsp.window.float { action = 'toggle' })
    hl.dsp.window.center()
end, { description = 'Focus Window in the Center' })
--hl.bind(mainMod .. ' + J', hl.dsp.layout 'togglesplit') -- dwindle only

hl.bind(mainMod .. ' + ESCAPE', hl.dsp.exec_cmd(terminal .. ' -e btop'), { description = 'Btop Task Manager' })

-- Function Keys
hl.bind(mainMod .. ' + F1', hl.dsp.exec_cmd(browser1), { description = 'Launch Firefox' })
hl.bind(mainMod .. ' + F2', hl.dsp.exec_cmd(browser2), { description = 'Launch Brave' })
hl.bind(mainMod .. ' + F3', hl.dsp.exec_cmd(mailclient), { description = 'Launch Thunderbird' })
hl.bind(mainMod .. ' + F4', hl.dsp.exec_cmd(editor), { description = 'Launch Editor' })
hl.bind(mainMod .. ' + F5', hl.dsp.exec_cmd(filesharing), { description = 'Launch LocalSend' })
hl.bind(mainMod .. ' + F6', hl.dsp.exec_cmd(mediaplayer), { description = 'Launch Media Player' })
hl.bind(mainMod .. ' + F7', hl.dsp.exec_cmd(vmmanager), { description = 'Launch Hypervisor' })
hl.bind(mainMod .. ' + F8', hl.dsp.exec_cmd(office), { description = 'Launch LibreOffice' })
hl.bind(mainMod .. ' + F9', hl.dsp.exec_cmd(pwmanager), { description = 'Launch KeepassXP' })
hl.bind(mainMod .. ' + F10', hl.dsp.exec_cmd(menu), { description = 'Launch Menu' })
hl.bind(mainMod .. ' + F11', hl.dsp.exec_cmd(dmenu), { description = 'Launch DMenu' })

hl.bind('F12', hl.dsp.exec_cmd '~/.config/hypr/scripts/idle.sh', { description = 'Toggle Enable Idle' })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. ' + left', hl.dsp.focus { direction = 'left' }, { description = 'Focus Window on the Right' })
hl.bind(mainMod .. ' + right', hl.dsp.focus { direction = 'right' }, { description = 'Focus Window on the Left' })
hl.bind(mainMod .. ' + up', hl.dsp.focus { direction = 'up' }, { description = 'Focus Window on the Top' })
hl.bind(mainMod .. ' + down', hl.dsp.focus { direction = 'down' }, { description = 'Focus Window on the Bottom' })
hl.bind('ALT + TAB', hl.dsp.window.cycle_next(), { description = 'Next Window' })
hl.bind('ALT + SHIFT + TAB', hl.dsp.window.cycle_next { next = false }, { description = 'Previous Window' })

-- Multi-monitor: move window / switch focused monitor
hl.bind(mainMod .. ' + O', hl.dsp.window.move { monitor = '+1' }, { description = 'Send Window to Other Monitor' })
hl.bind(mainMod .. ' + CTRL + right', hl.dsp.focus { monitor = '+1' }, { description = 'Focus Next Monitor' })
hl.bind(mainMod .. ' + CTRL + left', hl.dsp.focus { monitor = '-1' }, { description = 'Focus Previous Monitor' })
hl.bind(mainMod .. ' + 0', hl.dsp.focus { workspace = '10' }, { description = 'Focus Previous Monitor' })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- Per-monitor workspaces: SUPER+1..9 act on the focused monitor's own tag set
for i = 1, WS_PER_MON do
    hl.bind(mainMod .. ' + ' .. i, function()
        hl.dispatch(hl.dsp.focus { workspace = ws_base_of(hl.get_active_monitor()) + i })
    end, { description = 'Workspace ' .. i .. ' (focused monitor)' })

    hl.bind(mainMod .. ' + SHIFT + ' .. i, function()
        hl.dispatch(hl.dsp.window.move { workspace = ws_base_of(hl.get_active_monitor()) + i })
    end, { description = 'Send window to workspace ' .. i .. ' (focused monitor)' })
end

-- CTRL + ALT Keys

-- Example special workspace (scratchpad)
hl.bind(mainMod .. ' + S', hl.dsp.workspace.toggle_special 'magic', { description = 'Open Scrachpad' })
hl.bind(mainMod .. ' + SHIFT + S', hl.dsp.window.move { workspace = 'special:magic' }, { description = 'Sent Window to Scrachpad' })

-- Scroll through the focused monitor's workspaces with mainMod + scroll (wraps within monitor)
local function ws_relative(delta)
    return function()
        local m = hl.get_active_monitor()
        local base = ws_base_of(m)
        local cur = hl.get_active_workspace(m)
        local idx = cur and (cur.id - base) or 1
        idx = ((idx - 1 + delta) % WS_PER_MON) + 1
        hl.dispatch(hl.dsp.focus { workspace = base + idx })
    end
end
hl.bind(mainMod .. ' + mouse_down', ws_relative(1), { description = 'Next workspace (focused monitor)' })
hl.bind(mainMod .. ' + mouse_up', ws_relative(-1), { description = 'Prev workspace (focused monitor)' })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true }, { description = 'Mouse Move Window' })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true }, { description = 'Mouse Resise Window' })

-- Laptop multimedia keys for volume and LCD brightness
--hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd 'wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+', { locked = true, repeating = true })
--hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-', { locked = true, repeating = true })
--hl.bind('XF86AudioMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle', { locked = true, repeating = true })
--hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle', { locked = true, repeating = true })
--hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd 'amixer -q set %s 1%%+', { locked = true, repeating = true })
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd 'amixer -q set Master 2%+', { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd 'amixer -q set Master 2%-', { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd 'amixer -q set %s toggle', { locked = true, repeating = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'amixer set Capture toggle', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd 'brightnessctl -e4 -n2 set 5%+', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd 'brightnessctl -e4 -n2 set 5%-', { locked = true, repeating = true })

-- Requires playerctl
hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'playerctl next', { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd 'playerctl previous', { locked = true })
