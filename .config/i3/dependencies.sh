#!/bin/bash

# List of packages to install
packages=("rofi" "i3" "i3blocks" "feh" "iw")

# Update package list and install packages
echo "Updating package list..."
sudo apt update

echo "Installing packages: ${packages[*]}"
sudo apt install -y "${packages[@]}"

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "All packages installed successfully."
else
    echo "There was an error installing the packages."
fi
