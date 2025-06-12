#!/usr/bin/env bash

power=$(cat /sys/class/power_supply/BAT0/capacity)

while true; do
  if [ "$power" -le 20 ]; then # le for less than or equal to. ge for greater than
    icon="󰂃 "                  # Danger
    dunstify -u critical -h string:x-dunst-stack-tag:"$power" -h int:value:"$power" "$icon: $power%"
  fi
  sleep 10m
done

exit 0
