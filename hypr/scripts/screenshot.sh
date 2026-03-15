#!/bin/bash

# =========================================================
# Screenshot script for Hyprland
# Dependencies: grim, slurp, swappy
# =========================================================

GRIM=/usr/bin/grim
SLURP=/usr/bin/slurp
SWAPPY=/usr/bin/swappy

case "$1" in
    # Region select → edit in swappy
    region)
        $GRIM -g "$($SLURP)" - | $SWAPPY -f -
        ;;

    # Full screen → edit in swappy
    full)
        $GRIM - | $SWAPPY -f -
        ;;

    # Active window → edit in swappy
    window)
        FOCUSED=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        $GRIM -g "$FOCUSED" - | $SWAPPY -f -
        ;;

    *)
        echo "Usage: $0 [region|full|window]"
        exit 1
        ;;
esac
