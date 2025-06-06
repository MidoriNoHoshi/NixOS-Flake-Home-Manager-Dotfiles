#!/usr/bin/env bash

Bat0_Path="/sys/class/power_supply/BAT0"
power=$(cat "$Bat0_Path"/capacity)
status=$(cat "$Bat0_Path"/status)
icon="󰁹"
statusIcon="󰁹"

if ["$power" -ge 100 ]; then
  icon="󰁹" # Full
elif [ "$power" -ge 90 ]; then
  icon="󰂂"
elif [ "$power" -ge 80 ]; then
  icon="󰂁"
elif [ "$power" -ge 70 ]; then
  icon="󰂀"
elif [ "$power" -ge 60 ]; then
  icon="󰁿"
elif [ "$power" -ge 50 ]; then
  icon="󰁾"
elif [ "$power" -ge 40 ]; then
  icon="󰁽"
elif [ "$power" -ge 30 ]; then
  icon="󰁼"
elif [ "$power" -ge 20 ]; then
  icon="󰁻"
elif [ "$power" -ge 10 ]; then
  icon="󰁺"
fi

if [ "$status" = "Charging" ]; then
  statusIcon="󰶼 Charging"
elif [ "$status" = "Discharging" ]; then
  statusIcon="󰶹 Discharging"
elif [ "$status" = "Full" ]; then
  statusIcon="󰽙 Full"
fi

# Just realised, this "string:x-dunst-stack-tag" part just assigns the notificatios "tag". In other, here it just prevents dunst from showing how many times this notification was called. Doesn't actually do anything in terms of the content of the notification.
dunstify -h string:x-dunst-stack-tag:"$power" -h int:value:"$power" "$statusIcon $icon: $power%"
exit 0
