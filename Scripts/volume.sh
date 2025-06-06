#!/usr/bin/env bash

volume=$(wpctl get-volume @DEFAULT_SINK@)

volumeFloat=$(echo "$volume" | awk '{print $2}' | sed 's/\[MUTED]//')

volumePercent=$(printf "%.0f" "$(echo "$volumeFloat * 100" | bc)")

isMuted=""
icon=" "

if echo "$volume" | grep -q '\[MUTED\]'; then
  isMuted=" (Muted)"
  icon="󰕿"
fi

if [ "$volumePercent" -ge 60 ]; then
  icon="󰕾"
elif [ "$volumePercent" -ge 20 ]; then
  icon="󰖀"
fi

if echo "$volume" | grep -q '\[MUTED\]'; then
  isMuted=" (Muted)"
  icon="󰝟 "
fi

# --- Send the dunstify notification with the progress bar ---

dunstify -h string:x-dunst-stack-tag:volumePercent -h int:value:"$volumePercent" "$icon Volume: ${volumePercent}%${isMuted}"
exit 0
