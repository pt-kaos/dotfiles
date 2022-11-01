#!/usr/bin/bash

function run {
    if ! pgrep $1 ;
    then
        echo "$(date) : $@" >> $HOME/.config/awesome/awsome.log
        $@&
    fi
}

run "autorandr.sh"
run "picom --config $HOME/.config/picom/picom.conf"
run "numlockx on"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "pamac-tray"
#run "cbatticon"
run "battray"
#run "nm-applet"
run "nm-tray"
run "sb-volumeicon"
run "dropbox"
run "/usr/local/bin/QNAP/QsyncClient/Qsync.sh"
run "nitrogen --restore"
