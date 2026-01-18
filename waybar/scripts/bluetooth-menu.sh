#!/usr/bin/env bash
# Bluetooth device manager for Waybar
# Shows paired devices and allows connect/disconnect via rofi/wofi

# Detect which menu program is available
if command -v rofi &> /dev/null; then
    MENU="rofi -dmenu -i -theme ~/.config/rofi/rose-pine-moon-menu.rasi -p ''"
elif command -v wofi &> /dev/null; then
    MENU="wofi --dmenu --prompt 'Bluetooth'"
else
    notify-send "Bluetooth Menu" "No menu program found (rofi or wofi required)"
    exit 1
fi

# Check if Bluetooth is powered on
bt_power=$(bluetoothctl show | grep "Powered: yes")
if [ -z "$bt_power" ]; then
    choice=$(echo -e "󰂯	Turn Bluetooth On\n󰂯	Bluetooth Settings" | $MENU)
    case "$choice" in
        *"Turn Bluetooth On")
            bluetoothctl power on
            notify-send "Bluetooth" "Enabled" -i bluetooth
            pkill -RTMIN+9 waybar
            ;;
        *"Bluetooth Settings")
            if command -v blueman-manager &> /dev/null; then
                blueman-manager &
            elif command -v blueberry &> /dev/null; then
                blueberry &
            else
                notify-send "Error" "No Bluetooth settings GUI found"
            fi
            ;;
    esac
    exit 0
fi

# Get list of paired devices
mapfile -t paired_devices < <(bluetoothctl devices Paired | awk '{print $2 "|" substr($0, index($0,$3))}')

if [ ${#paired_devices[@]} -eq 0 ]; then
    choice=$(echo -e "No paired devices\n󰐲	Scan for devices\n󰂲	Turn Bluetooth Off\n󰂯	Bluetooth Settings" | $MENU)
    case "$choice" in
        *"Scan for devices")
            notify-send "Bluetooth" "Scanning for devices..." -i bluetooth
            (
                bluetoothctl scan on &
                SCAN_PID=$!
                sleep 10
                kill $SCAN_PID
                notify-send "Bluetooth" "Scan complete" -i bluetooth
            ) &
            ;;
        *"Turn Bluetooth Off")
            bluetoothctl power off
            notify-send "Bluetooth" "Disabled" -i bluetooth-disabled
            pkill -RTMIN+9 waybar
            ;;
        *"Bluetooth Settings")
            if command -v blueman-manager &> /dev/null; then
                blueman-manager &
            elif command -v blueberry &> /dev/null; then
                blueberry &
            else
                notify-send "Error" "No Bluetooth settings GUI found"
            fi
            ;;
    esac
    exit 0
fi

# Build device menu
declare -a menu_items
declare -a device_macs
declare -a device_names

for device in "${paired_devices[@]}"; do
    mac=$(echo "$device" | cut -d'|' -f1)
    name=$(echo "$device" | cut -d'|' -f2)
    
    # Check if device is connected
    device_info=$(bluetoothctl info "$mac")
    if echo "$device_info" | grep -q "Connected: yes"; then
        icon="󰂱"  # Connected
        status="Connected"
    else
        icon="󰂲"  # Disconnected
        status="Disconnected"
    fi
    
    menu_items+=("$icon	$name ($status)")
    device_macs+=("$mac")
    device_names+=("$name")
done

# Add management options
menu_items+=("---")
menu_items+=("󰐲	Scan for devices")
menu_items+=("󰂲	Turn Bluetooth Off")
menu_items+=("󰂯	Bluetooth Settings")

# Show menu
choice=$(printf '%s\n' "${menu_items[@]}" | $MENU)

# Handle choice
if [ -z "$choice" ]; then
    exit 0
fi

# Find selected device index
for i in "${!menu_items[@]}"; do
    if [ "${menu_items[$i]}" = "$choice" ]; then
        selected_index=$i
        break
    fi
done

# Handle device selection
if [ -n "$selected_index" ] && [ "$selected_index" -lt ${#device_macs[@]} ]; then
    mac="${device_macs[$selected_index]}"
    name="${device_names[$selected_index]}"
    
    # Check if connected
    device_info=$(bluetoothctl info "$mac")
    if echo "$device_info" | grep -q "Connected: yes"; then
        # Disconnect
        bluetoothctl disconnect "$mac"
        notify-send "Bluetooth" "Disconnected from $name" -i bluetooth-disabled
    else
        # Connect
        notify-send "Bluetooth" "Connecting to $name..." -i bluetooth
        if bluetoothctl connect "$mac"; then
            notify-send "Bluetooth" "Connected to $name" -i bluetooth
        else
            notify-send "Bluetooth" "Failed to connect to $name" -i dialog-error
        fi
    fi
    pkill -RTMIN+9 waybar
elif [[ "$choice" == *"Scan for devices"* ]]; then
    notify-send "Bluetooth" "Scanning for devices..." -i bluetooth
    (
        bluetoothctl scan on &
        SCAN_PID=$!
        sleep 10
        kill $SCAN_PID
        notify-send "Bluetooth" "Scan complete. Use bluetoothctl to pair new devices." -i bluetooth
    ) &
elif [[ "$choice" == *"Turn Bluetooth Off"* ]]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Disabled" -i bluetooth-disabled
    pkill -RTMIN+9 waybar
elif [[ "$choice" == *"Bluetooth Settings"* ]]; then
    if command -v blueman-manager &> /dev/null; then
        blueman-manager &
    elif command -v blueberry &> /dev/null; then
        blueberry &
    else
        notify-send "Error" "No Bluetooth settings GUI found"
    fi
fi
