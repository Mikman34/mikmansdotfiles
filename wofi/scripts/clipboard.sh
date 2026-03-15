#!/bin/bash

# =========================================================
# Clipboard history manager for Hyprland
# Dependencies: cliphist, wofi, wl-copy
# =========================================================

CLIPHIST=/usr/bin/cliphist
WOFI=/usr/bin/wofi
WL_COPY=/usr/bin/wl-copy
PGREP=/usr/bin/pgrep
PKILL=/usr/bin/pkill
STYLE=~/.config/wofi/clipboard.css

# Toggle: close Wofi if already running
if $PGREP -x wofi > /dev/null; then
    $PKILL -x wofi
    exit 0
fi

while true; do
    # Build item list with clear option at top
    ITEMS="󰆴  Clear Clipboard History"$'\n'$($CLIPHIST list)

    CHOICE=$(echo "$ITEMS" | $WOFI \
        --show dmenu \
        --prompt "  Clipboard" \
        --lines 15 \
        --width 600 \
        --style "$STYLE" \
        --no-actions \
        --insensitive)

    # Exit if user pressed escape or closed
    [ -z "$CHOICE" ] && break

    if [[ "$CHOICE" == "󰆴  Clear Clipboard History" ]]; then
        $CLIPHIST wipe
        notify-send -u low "Clipboard" "History cleared" -i edit-clear
        # Loop continues → menu refreshes
    else
        echo "$CHOICE" | $CLIPHIST decode | $WL_COPY
        notify-send -u low "Clipboard" "Copied to clipboard" -i edit-copy
        break
    fi
done
