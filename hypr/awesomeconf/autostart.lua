-- ██╗  ██╗ █████╗  ██████╗ ███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
-- ██║ ██╔╝██╔══██╗██╔═══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
-- █████╔╝ ███████║██║   ██║███████╗███████║██████╔╝██║     ███████║
-- ██╔═██╗ ██╔══██║██║   ██║╚════██║██╔══██║██╔══██╗██║     ██╔══██║
-- ██║  ██╗██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╗██║  ██║
-- ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
--
hl.on('hyprland.start', function()
    hl.exec_cmd 'nm-applet --indicator'
    hl.exec_cmd 'hyprpolkitagent'
    hl.exec_cmd 'hyprpaper'
    hl.exec_cmd 'hypridle'
    --hl.exec_cmd 'nitrogen --restore'
    hl.exec_cmd 'pamac-tray'
    hl.exec_cmd 'blueberry-tray'
    hl.exec_cmd 'numlockx on'
    hl.exec_cmd 'Qsync'
    hl.exec_cmd 'hyprlauncher -d'
    --hl.exec_cmd 'qs'
    hl.exec_cmd 'waybar'
end)
