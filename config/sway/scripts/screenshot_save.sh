#!/bin/bash

# Use slurp to select a region
REGION=$(slurp)

if [ -z "$REGION" ]; then
    echo "No region selected. Exiting."
    exit 1
fi

# Use grim to take a screenshot of the selected region
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
SAVE_PATH=~/Pictures/screenshot_$TIMESTAMP.png
grim -g "$REGION" "$SAVE_PATH"

echo "Screenshot saved to $SAVE_PATH."
