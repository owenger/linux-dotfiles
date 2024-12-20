#!/bin/bash
DISPLAY_NAME="eDP-1"  # Replace with the actual name of your integrated display
STATUS=$(hyprctl monitors | grep "$DISPLAY_NAME")

if [[ -n "$STATUS" ]]; then
    hyprctl dispatch dpms off "$DISPLAY_NAME"
    hyprctl keyword monitor "$DISPLAY_NAME,disable"
else
    hyprctl keyword monitor "$DISPLAY_NAME,auto,0x0,1"
    hyprctl dispatch dpms on "$DISPLAY_NAME"
fi

