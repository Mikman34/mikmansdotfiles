#!/bin/bash

# Check if Wofi is already running
if pgrep -x wofi > /dev/null; then
    # Close it
    pkill -x wofi
else
    # Launch it
    wofi --show drun &
fi

