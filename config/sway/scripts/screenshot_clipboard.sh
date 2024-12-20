#!/bin/bash

# Use slurp to select a region
REGION=$(slurp)

if [ -z "$REGION" ]; then
    echo "No region selected. Exiting."
    exit 1
fi

# Use grim to take a screenshot of the selected region and pipe to wl-copy
grim -g "$REGION" - | wl-copy

echo "Screenshot copied to clipboard."
