#!/bin/sh

set -e

logger -t autorandr "ACTION: $ACTION" # "change"
logger -t autorandr "SUBSYSTEM: $SUBSYSTEM" # "drm"

# BUG: wait a bit before checking the config, the UDEV rule might run before the actual change -_-
sleep 1

# BUG: device on /sys/class/drm does not update without forcing an update with xrandr
logger -t autorandr "Reading monitor configuration..."
xrandr > /dev/null

# change this to your external monitor device
EXTERNAL_MONITOR=HDMI1
if [ -f '/sys/class/drm/card0-HDMI-A-1/status' ]; then
	EXTERNAL_MONITOR_STATUS=$( cat /sys/class/drm/card0-HDMI-A-1/status )
else
	EXTERNAL_MONITOR_STATUS=$( cat /sys/class/drm/card1-HDMI-A-1/status )
fi

echo "External monitor is: $EXTERNAL_MONITOR_STATUS"

# Is the external monitor connected?
if [ "$EXTERNAL_MONITOR_STATUS" = "connected" ]; then
    TYPE="double"
    /usr/bin/xrandr --output eDP1 --primary --auto --rotate normal --output $EXTERNAL_MONITOR --auto --rotate normal --right-of eDP1
    nitrogen --restore
else
    TYPE="single"
    /usr/bin/xrandr --output $EXTERNAL_MONITOR --off --output eDP1 --mode auto --pos 0x0 --rotate normal
    nitrogen --restore
fi

logger -t autorandr "Switched to $TYPE monitor mode"

exit 0

    #/usr/bin/xrandr --output $EXTERNAL_MONITOR --mode 1280x1024 --pos 0x0 --rotate normal --output eDP1 --primary --mode 1366x768 --pos 1280x0 --rotate normal
	# feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg

