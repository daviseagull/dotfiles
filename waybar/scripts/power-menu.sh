#!/bin/bash

# Rose Pine Moon themed power menu
# Uses rofi to display power options

# Power options
shutdown="󰐥	Shutdown"
reboot="󰜉	Restart"
logout="󰍃	Logout"
suspend="󰤄	Suspend"
lock="󰌾	Lock"

# Show rofi menu and get selection
selected=$(echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | rofi -dmenu -i -theme ~/.config/rofi/rose-pine-moon-menu.rasi -p "")

# Execute based on selection
case $selected in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $logout)
        # For Hyprland
        hyprctl dispatch exit
        ;;
    $suspend)
        systemctl suspend
        ;;
    $lock)
        # Adjust this based on your lock screen command
        # Common options: hyprlock, swaylock, gtklock
        hyprlock
        ;;
esac
