#!/bin/bash

# Get the current active player
PLAYER=$(playerctl -l 2>/dev/null | head -n1)

if [ -z "$PLAYER" ]; then
    exit 0
fi

# Extract the base player name (e.g., firefox, spotify, etc.)
PLAYER_NAME=$(echo "$PLAYER" | cut -d'.' -f1)

# Try to focus the window using hyprctl
# For browsers, we use regex to match Firefox and its forks (Zen, Floorp, LibreWolf, etc.)
case "$PLAYER_NAME" in
    firefox|Firefox)
        # Match Firefox and all Firefox-based browsers
        hyprctl dispatch focuswindow "class:^(firefox|zen|floorp|librewolf)$"
        ;;
    spotify|Spotify)
        hyprctl dispatch focuswindow "class:Spotify"
        ;;
    chromium|Chromium|chrome)
        hyprctl dispatch focuswindow "class:^(chromium|google-chrome|brave)$"
        ;;
    mpv)
        hyprctl dispatch focuswindow "class:mpv"
        ;;
    vlc)
        hyprctl dispatch focuswindow "class:vlc"
        ;;
    *)
        # Try to focus using the player name directly
        hyprctl dispatch focuswindow "class:$PLAYER_NAME"
        ;;
esac
