#!/bin/bash

WIDTH="dynamic"
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
	WIDTH="0"
	sketchybar --set $NAME icon="◦"
else 
	sketchybar --set $NAME icon=""
fi

sketchybar --animate tanh 20 --set $NAME label.width=$WIDTH
