#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
# polybar -c ~/.config/polybar/config.ini dummy &
# polybar -c ~/.config/polybar/config.ini dummy2 &
polybar -c ~/.config/polybar/config.ini main &
polybar -c ~/.config/polybar/config.ini second &
