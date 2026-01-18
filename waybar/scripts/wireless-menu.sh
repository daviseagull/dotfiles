#!/usr/bin/env bash
# Wireless toggle menu for WiFi and Bluetooth
# Uses rofi/wofi to display toggle options

# Detect which menu program is available
if command -v rofi &> /dev/null; then
    MENU="rofi -dmenu -i -theme ~/.config/rofi/rose-pine-moon-menu.rasi -p ''"
elif command -v wofi &> /dev/null; then
    MENU="wofi --dmenu --prompt 'Wireless'"
else
    notify-send "Wireless Menu" "No menu program found (rofi or wofi required)"
    exit 1
fi

# Get current status
get_wifi_status() {
    if nmcli radio wifi | grep -q "enabled"; then
        echo "on"
    else
        echo "off"
    fi
}

get_bluetooth_status() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        echo "on"
    else
        echo "off"
    fi
}

wifi_status=$(get_wifi_status)
bt_status=$(get_bluetooth_status)

# Build menu options
if [[ "$wifi_status" == "on" ]]; then
    wifi_option="󰖪	Turn WiFi Off"
else
    wifi_option="󰖩	Turn WiFi On"
fi

if [[ "$bt_status" == "on" ]]; then
    bt_option="󰂲	Turn Bluetooth Off"
else
    bt_option="󰂯	Turn Bluetooth On"
fi

# Show menu
choice=$(echo -e "${wifi_option}\n${bt_option}\n󰤨	WiFi Networks\n󰂱	Bluetooth Devices\n󰍺	Network Settings" | $MENU)

# Execute action based on choice
case "$choice" in
    *"WiFi On")
        nmcli radio wifi on
        notify-send "WiFi" "Enabled" -i network-wireless
        ;;
    *"WiFi Off")
        nmcli radio wifi off
        notify-send "WiFi" "Disabled" -i network-wireless-disabled
        ;;
    *"Bluetooth On")
        bluetoothctl power on
        notify-send "Bluetooth" "Enabled" -i bluetooth
        ;;
    *"Bluetooth Off")
        bluetoothctl power off
        notify-send "Bluetooth" "Disabled" -i bluetooth-disabled
        ;;
    *"Network Settings")
        if command -v nm-connection-editor &> /dev/null; then
            nm-connection-editor &
        else
            notify-send "Error" "Network settings not found"
        fi
        ;;
    *"WiFi Networks")
        ~/.config/waybar/scripts/wifi-menu.sh
        ;;
    *"Bluetooth Devices")
        ~/.config/waybar/scripts/bluetooth-menu.sh
        ;;
esac

# Signal waybar to update
pkill -RTMIN+9 waybar
