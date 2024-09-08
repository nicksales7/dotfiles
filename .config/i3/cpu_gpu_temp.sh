#!/bin/bash

# Get CPU temperature
cpu_temp=$(sensors | awk '/^temp1:/{print $2}' | sed 's/+//;s/°C//')

# Get GPU temperature
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | awk '{print $1}')

# Format output
formatted_cpu_temp=$(printf "%.1f°C" "$cpu_temp")
formatted_gpu_temp=$(printf "%.1f°C" "$gpu_temp")

# Print formatted temperatures
echo "CPU/GPU: $formatted_cpu_temp -  $formatted_gpu_temp"

