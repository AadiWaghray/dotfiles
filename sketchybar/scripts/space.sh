#!/usr/bin/env bash

result="$($HELPER_DIR/app_label.sh "$1")"
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
	sketchybar --set $NAME background.drawing=true
else
	sketchybar --set $NAME background.drawing=false
fi
