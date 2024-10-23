#!/bin/bash

# Time in seconds before dimming the screen
INACTIVITY_TIMEOUT=240  # 4 minutes

# Dim brightness value (e.g., 50% brightness)
DIM_BRIGHTNESS=50

# Normal brightness value (e.g., 100% brightness)
NORMAL_BRIGHTNESS=100

while true; do
    # Get the idle time in milliseconds
    idle_time=$(xprintidle)

    if [ "$idle_time" -ge $((INACTIVITY_TIMEOUT * 1000)) ]; then
        # Dim the screen if idle for more than the specified timeout
        sudo brightnessctl set ${DIM_BRIGHTNESS}%
    else
        # Return to normal brightness if there's input
        sudo brightnessctl set ${NORMAL_BRIGHTNESS}%
    fi

    # Check every 5 seconds
    sleep 5
done
