#!/bin/bash

if [ -z "$(xdotool search --classname "$1")" ]; then
  i3-msg "exec --no-startup-id kitty --name $1 -- ${*:2} "
  sleep 1
  i3-msg "[instance=\"$1\"] border pixel 4, move absolute position center"
  i3-msg "[instance=\"$1\"] resize set 1600px 900px, scratchpad show"
else
  i3-msg "[instance=\"$1\"] scratchpad show"
fi
