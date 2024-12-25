#!/usr/bin/env bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
	source "$HELPER_DIR/app_label.sh" $sid

	space=(
		padding_left=2
		padding_right=2
		icon="$sid"
		icon.color=$GREY
		icon.font="hack-nerd-font:Regular:13"
		icon.highlight_color=$WHITE
		icon.padding_left=10
		icon.padding_right=10
		label="$icon_strip"
		label.padding_right=20
		label.color=$GREY
		label.highlight_color=$WHITE
		label.font="sketchybar-app-font:Regular:16.0"
		background.color=$BACKGROUND_1
		background.border_color=$BACKGROUND_2
		background.border_width=5
		background.corner_radius=4
		background.height=25
		script="$SCRIPT_DIR/space.sh $sid"
		click_script="aerospace workspace $sid"
	)

	sketchybar --add item space.$sid left \
		--subscribe space.$sid aerospace_workspace_change \
		--set space.$sid "${space[@]}"
done

#NOTE: You need to set background color for border to show
sketchybar --add bracket spaces '/space\..*/' \
		   --set         spaces background.color=0x00ffffff \
							    background.corner_radius=4  \
								background.height=30 \
								background.border_color=0xffffffff \
								background.border_width=1
