#!/bin/bash

INTERNAL_DISPLAY="eDP-1"

if ! command -v jq &> /dev/null; then
    echo "This script requires 'jq'. Please install it first."
    exit 1
fi

MONITORS_JSON=$(hyprctl monitors -j)
EXTERNALS=$(echo "$MONITORS_JSON" | jq -r ".[] | select(.name != \"$INTERNAL_DISPLAY\") | .name")

readarray -t MONITORS <<< "$EXTERNALS"

if [[ ${#MONITORS[@]} -ne 2 ]]; then
    echo "Exactly two external monitors must be active (excluding $INTERNAL_DISPLAY). Found: ${#MONITORS[@]}"
    exit 1
fi

get_resolution() {
    local NAME="$1"
    echo "$MONITORS_JSON" | jq -r ".[] | select(.name == \"$NAME\") | \"\(.width),\(.height)\""
}

RES0=$(get_resolution "${MONITORS[0]}")
RES1=$(get_resolution "${MONITORS[1]}")

WIDTH0=$(echo "$RES0" | cut -d',' -f1)

echo "Swapping monitor positions:"
echo "${MONITORS[0]} => ${RES0} at ${WIDTH0}x0"
echo "${MONITORS[1]} => ${RES2} at 0x0"

hyprctl keyword monitor "${MONITORS[0]},preferred,${WIDTH1}x0"
hyprctl keyword monitor "${MONITORS[1]},preferred,0x0"
