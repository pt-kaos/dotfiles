#!/bin/bash

is_app_running(){
    local process_name=$1
    if pgrep -f "$process_name" >/dev/null; then
        process_name=""
        return 0  # Process is running
    else
        process_name=""
        return 1  # Process is not running
    fi
}

run() {
    local app=$1
    shift         # Shift the arguments to get the remaining ones

    if ! is_app_running $app ;
    then
#        echo "PT: Starting: $app with arguments: $@"
        "$app" "$@" &
#    else
#        echo "PT: $app is already running."
    fi
    app=""
}

#run xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#run xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#run autorandr.sh
#autorandr horizontal
run nm-applet
run pamac-tray
run xfce4-power-manager
run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon
run dropbox
run /usr/local/bin/QNAP/QsyncClient/Qsync.sh
run nitrogen --restore

#run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop   # Este ficheiro não existe
#run caffeine
#run variety
#run conky -c $HOME/.config/awesome/system-overview

##### you can set wallpapers in themes as well
#feh --bg-fill /usr/share/backgrounds/archlinux/arch-wallpaper.jpg &
#feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &

##### run applications from startup
#run insync start
#run ckb-next -b
#run discord
#run telegram-desktop
