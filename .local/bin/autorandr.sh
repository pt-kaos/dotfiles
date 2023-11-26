#!/usr/bin/bash

set -e

logger -t autorandr "ACTION: $ACTION" # "change"
logger -t autorandr "SUBSYSTEM: $SUBSYSTEM" # "drm"

# BUG: wait a bit before checking the config, the UDEV rule might run before the actual change -_-
sleep 1

# BUG: device on /sys/class/drm does not update without forcing an update with xrandr
logger -t autorandr "Reading monitor configuration..."
#xrandr > /dev/null

TYPE="single"

configure_monitors() {

  # Filter connected monitors
  connected_monitors=()
  while IFS= read -r line; do
      monitor_name=$(echo "$line" | grep -i " connected" | awk '{print $1}')

      if [[ $monitor_name ]]; then
          connected_monitors+=("$monitor_name")
      fi
  done <<< "$(xrandr)"

  echo "Connected monitors: "${connected_monitors[@]}

  #COMMAND="/usr/bin/xrandr --output eDP1 --primary --auto --rotate normal"
  COMMAND="/usr/bin/xrandr"

  # Configure connected monitors
  for monitor in "${connected_monitors[@]}"; do
    case $monitor in
        eDP1 | eDP-1 | eDP-1-1) # Normal positioned monitor
            TYPE="double"
	        # EXTERNAL_MONITOR_STATUS="connected"
            COMMAND=$COMMAND" --output "$monitor" --primary --auto --rotate normal"
            echo "External monitor $monitor is: connected"
            PRIMARY=$monitor
            ;;
        DP1 | DP-1 | DP-1-0 | DP-1-1) # Normal positioned monitor
            TYPE="double"
	        EXTERNAL_MONITOR_STATUS="connected"
            COMMAND=$COMMAND" --output "$monitor" --auto --rotate normal --right-of $PRIMARY"
            echo "External monitor $monitor is: connected"
            ;;
        DP2 | DP-2 | DP-2-0 | DP-2-1) # Normal positioned monitor
            TYPE="double"
	        EXTERNAL_MONITOR_STATUS="connected"
            COMMAND=$COMMAND" --output "$monitor" --auto --rotate normal --right-of $PRIMARY"
            echo "External monitor $monitor is: connected"
            ;;
        HDMI1 | HDMI-1 | HDMI-1-0 | HDMI-1-1) # Small Monitor in table 1
            TYPE="double"
	        EXTERNAL_MONITOR_STATUS="connected"
            COMMAND=$COMMAND" --output "$monitor" --auto --rotate normal --left-of $PRIMARY"
            echo "External monitor $monitor is: connected"
            ;;
        HDMI2 | HDMI-2 | HDMI-2-0 | HDMI-2-1) # Small Monitor in table 1
            TYPE="double"
	        EXTERNAL_MONITOR_STATUS="connected"
            COMMAND=$COMMAND" --output "$monitor" --auto --rotate normal --left-of $PRIMARY"
            echo "External monitor $monitor is: connected"
            ;;
        *) #Display usage
            ;;
    esac
  done
  $COMMAND
}

# change this to your external monitor device

configure_monitors

nitrogen --restore

logger -t autorandr "Switched to $TYPE monitor mode"

exit 0

    #/usr/bin/xrandr --output $EXTERNAL_MONITOR --mode 1280x1024 --pos 0x0 --rotate normal --output eDP1 --primary --mode 1366x768 --pos 1280x0 --rotate normal
	# feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg
