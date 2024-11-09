#!/bin/bash

while true; do
    IDLE_TIME=$(xprintidle)
    if [ "$IDLE_TIME" -ge 300000 ]; then  # 5 minutes = 300000 ms
        systemctl suspend
    fi
    sleep 10
done
