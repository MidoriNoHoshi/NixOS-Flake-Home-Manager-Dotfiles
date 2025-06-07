#!/usr/bin/env bash

power=$(cat /sys/class/power_supply/Bat0/capacity)

if ["$power" -ge 30 ]; then
  icon="󰂃 " # Danger
  dunstify -u critical -h string:x-dunst-stack-tag:"$power" -h int:value:"$power" "$icon: $power%"
fi

exit 0
