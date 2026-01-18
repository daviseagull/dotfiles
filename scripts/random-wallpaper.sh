#!/bin/bash

# Random wallpaper selector for hyprpaper
# Usage: ./random-wallpaper.sh [monitor]
# If no monitor specified, defaults to DP-3

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
MONITOR="${1:-DP-3}"

# Wait for hyprpaper to be ready
sleep 2

# Get array of all wallpapers
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | sort)

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Select random wallpaper
random_index=$((RANDOM % ${#wallpapers[@]}))
selected_wallpaper="${wallpapers[$random_index]}"

# Get just the filename for display
filename=$(basename "$selected_wallpaper")

echo "Setting wallpaper: $filename"

# Set the wallpaper using hyprctl
hyprctl hyprpaper wallpaper "$MONITOR,$selected_wallpaper" 2>&1

if [ $? -eq 0 ]; then
    echo "✓ Wallpaper set successfully on $MONITOR"
else
    echo "✗ Failed to set wallpaper"
    exit 1
fi
