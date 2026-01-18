#!/usr/bin/env bash
# Wireless status display for Waybar
# Shows combined WiFi and Bluetooth status

get_wifi_status() {
    if command -v nmcli &> /dev/null; then
        nmcli radio wifi
    else
        echo "unknown"
    fi
}

get_bluetooth_status() {
    if command -v bluetoothctl &> /dev/null; then
        if bluetoothctl show | grep -q "Powered: yes"; then
            echo "enabled"
        else
            echo "disabled"
        fi
    else
        echo "unknown"
    fi
}

wifi_status=$(get_wifi_status)
bt_status=$(get_bluetooth_status)

# Determine icon display and styling based on status
if [[ "$wifi_status" == "enabled" ]] && [[ "$bt_status" == "enabled" ]]; then
    icon="󰖩 󰂯"
    text="WiFi + BT"
    class="both-on"
elif [[ "$wifi_status" == "enabled" ]]; then
    icon="󰖩 <span color='#6e6a86'>󰂯</span>"
    text="WiFi"
    class="wifi-on"
elif [[ "$bt_status" == "enabled" ]]; then
    icon="<span color='#6e6a86'>󰖪</span> 󰂯"
    text="BT"
    class="bt-on"
else
    icon="<span color='#6e6a86'>󰖪 󰂯</span>"
    text="Offline"
    class="both-off"
fi

# Output JSON for Waybar
echo "{\"text\": \"$icon\", \"tooltip\": \"$text\", \"class\": \"$class\"}"
