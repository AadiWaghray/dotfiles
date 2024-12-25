#!/usr/bin/env bash

apps=$(aerospace list-windows --workspace $1 | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
echo "$1" >> ~/test_1.txt

icon_strip=" "
if [ "${apps}" != "" ]; then
	while read -r app
	do
		icon_strip+=" $($PLUGIN_DIR/icon_map.sh "$app")"
	done <<< "${apps}"
fi
echo $icon_strip
