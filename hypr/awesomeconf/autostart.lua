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
    -- Re-assert the theme (gsettings / GTK / Kvantum) from theme/palette.sh.
    hl.exec_cmd '~/.config/theme/apply.sh --boot'
    hl.exec_cmd 'nm-applet --indicator'
    -- hl.exec_cmd 'hyprpolkitagent'
    hl.exec_cmd 'hyprpaper'
    hl.exec_cmd 'hypridle'
    --hl.exec_cmd 'nitrogen --restore'
    -- pamac-tray dropped: this build has no libappindicator/SNI support, so it
    -- can never register with waybar's tray under Wayland. Replaced by the
    -- "custom/updates" waybar module (see waybar/updates.sh).
    hl.exec_cmd 'blueberry-tray'
    -- hl.exec_cmd 'numlockx on'
    hl.exec_cmd 'hyprlauncher -d'
    --hl.exec_cmd 'qs'
    hl.exec_cmd 'waybar 2>&1 | logger -t waybar'
    -- battery popup: Waybar battery on-click toggles it (quickshell ipc call battery toggle).
    hl.exec_cmd 'quickshell -p ~/.config/quickshell/battery-popup'
    -- kaos-launcher: resident Quickshell instance, hidden until F11 toggles it.
    -- The wrapper starts it with `quickshell -n` (single instance).
    hl.exec_cmd 'sleep 2 && KAOS_START_HIDDEN=1 /home/pedro/Documents/_MyAgenticOS/Projects/kaos-launcher/app/kaos-launcher'
    -- QNAP Qsync: launch via its bundled wrapper, NOT the raw binary. The wrapper
    -- exports LD_LIBRARY_PATH=/usr/local/lib/QNAP/QsyncClient and runs from the
    -- app dir so Qt can load its platform plugin; the bare binary core-dumps on
    -- start ("no Qt platform plugin could be initialized"). The sleep lets
    -- waybar claim org.kde.StatusNotifierWatcher first so the tray icon registers.
    hl.exec_cmd 'sleep 3 && exec /usr/local/bin/QNAP/QsyncClient/Qsync.sh'
end)
