#!/bin/bash

# Set the desired brightness levels
LOW_BRIGHTNESS="5"
HIGH_BRIGHTNESS="100"

# Duration of inactivity in seconds
INACTIVITY_LIMIT=240

# Initialize current brightness state
CURRENT_BRIGHTNESS=""
SLEEP_DURATION=10  # Start with a longer sleep time

# Main loop
while true; do
    # Get the idle time in milliseconds
    IDLE_TIME=$(xprintidle)

    if [ "$IDLE_TIME" -ge "$((INACTIVITY_LIMIT * 1000))" ]; then
        # Set low brightness after 4 minutes of inactivity
        if [ "$CURRENT_BRIGHTNESS" != "$LOW_BRIGHTNESS" ]; then
            light -S $LOW_BRIGHTNESS
            CURRENT_BRIGHTNESS=$LOW_BRIGHTNESS
            SLEEP_DURATION=1  # Switch to shorter sleep duration
        fi
    else
        # Set high brightness if there is activity
        if [ "$CURRENT_BRIGHTNESS" != "$HIGH_BRIGHTNESS" ]; then
            light -S $HIGH_BRIGHTNESS
            CURRENT_BRIGHTNESS=$HIGH_BRIGHTNESS
            SLEEP_DURATION=10  # Switch back to longer sleep duration
        fi
    fi

    # Sleep for the determined duration
    sleep $SLEEP_DURATION
done
