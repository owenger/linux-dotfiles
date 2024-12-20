#!/bin/bash

# Use slurp to select a region
REGION=$(slurp)

if [ -z "$REGION" ]; then
    echo "No region selected. Exiting."
    exit 1
fi

# Use grim to take a screenshot of the selected region
TEMP_FILE=$(mktemp /tmp/screenshot-XXXXXX.png)
grim -g "$REGION" "$TEMP_FILE"

# Show key options to the user
echo "Screenshot captured. Press:"
echo "  Ctrl+C to copy to clipboard"
echo "  Ctrl+S to save to a file"
echo "  Esc to cancel"

# Read user input for action
while true; do
    read -rsn1 INPUT
    case "$INPUT" in
        $'\x03') # Ctrl+C
            cat "$TEMP_FILE" | wl-copy
            echo "Screenshot copied to clipboard."
            break
            ;;
        $'\x13') # Ctrl+S
            TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
            SAVE_PATH=~/Pictures/screenshot_$TIMESTAMP.png
            mv "$TEMP_FILE" "$SAVE_PATH"
            echo "Screenshot saved to $SAVE_PATH."
            break
            ;;
        $'\x1b') # Esc
            echo "Action canceled."
            break
            ;;
        *)
            echo "Invalid input. Press Ctrl+C, Ctrl+S, or Esc."
            ;;
    esac
done

# Clean up temporary file
rm -f "$TEMP_FILE"

