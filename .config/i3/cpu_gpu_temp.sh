#!/bin/sh

# Adjusting the pattern to match the Tctl temperature for CPU
cpu_temp=$(sensors | grep 'Tctl' | awk '{print substr($2, 2)}')
gpu_temp=$(sensors | grep 'edge:' | awk '{print substr($2, 2)}')

echo "CPU: $cpu_temp GPU: $gpu_temp"

