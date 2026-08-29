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
    -- pamac-tray dropped: this build has no libappindicator/SNI support, so it
    -- can never register with waybar's tray under Wayland. Replaced by the
    -- "custom/updates" waybar module (see waybar/updates.sh).
    hl.exec_cmd 'blueberry-tray'
    hl.exec_cmd 'numlockx on'
    hl.exec_cmd '/usr/local/bin/QNAP/QsyncClient/Qsync'
    hl.exec_cmd 'hyprlauncher -d'
    --hl.exec_cmd 'qs'
    hl.exec_cmd 'waybar'
end)
