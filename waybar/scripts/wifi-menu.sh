#!/usr/bin/env bash
# WiFi network manager for Waybar
# Shows available networks and allows connect/disconnect via rofi/wofi

# Detect which menu program is available
if command -v rofi &> /dev/null; then
    MENU="rofi -dmenu -i -theme ~/.config/rofi/rose-pine-moon-menu.rasi -p ''"
    MENU_PASS="rofi -dmenu -password -theme ~/.config/rofi/rose-pine-moon-menu.rasi -p ''"
elif command -v wofi &> /dev/null; then
    MENU="wofi --dmenu --prompt 'WiFi'"
    MENU_PASS="wofi --dmenu --password --prompt 'Password'"
else
    notify-send "WiFi Menu" "No menu program found (rofi or wofi required)"
    exit 1
fi

# Check if WiFi is enabled
wifi_status=$(nmcli radio wifi)
if [ "$wifi_status" != "enabled" ]; then
    choice=$(echo -e "󰖩	Turn WiFi On\n󰍺	Network Settings" | $MENU)
    case "$choice" in
        *"Turn WiFi On")
            nmcli radio wifi on
            notify-send "WiFi" "Enabled" -i network-wireless
            pkill -RTMIN+9 waybar
            ;;
        *"Network Settings")
            if command -v nm-connection-editor &> /dev/null; then
                nm-connection-editor &
            else
                notify-send "Error" "Network settings not found"
            fi
            ;;
    esac
    exit 0
fi

# Get current connection
current_connection=$(nmcli -t -f NAME connection show --active | grep -v 'lo' | head -1)

# Scan for networks (this updates the list)
nmcli device wifi rescan 2>/dev/null

# Get list of available networks
mapfile -t networks < <(nmcli -f SSID,SECURITY,SIGNAL,BARS device wifi list | tail -n +2)

if [ ${#networks[@]} -eq 0 ]; then
    choice=$(echo -e "No networks found\n󰑓	Rescan\n󰖪	Turn WiFi Off\n󰍺	Network Settings" | $MENU)
    case "$choice" in
        *"Rescan")
            notify-send "WiFi" "Scanning for networks..." -i network-wireless
            nmcli device wifi rescan
            sleep 2
            exec "$0"
            ;;
        *"Turn WiFi Off")
            nmcli radio wifi off
            notify-send "WiFi" "Disabled" -i network-wireless-disabled
            pkill -RTMIN+9 waybar
            ;;
        *"Network Settings")
            if command -v nm-connection-editor &> /dev/null; then
                nm-connection-editor &
            else
                notify-send "Error" "Network settings not found"
            fi
            ;;
    esac
    exit 0
fi

# Build network menu
declare -a menu_items
declare -a ssid_list

for network in "${networks[@]}"; do
    # Parse network info - nmcli output: SSID SECURITY SIGNAL BARS
    # Security can have spaces, so we need to extract signal more carefully
    ssid=$(echo "$network" | awk '{print $1}')
    
    # Skip empty SSIDs
    [ -z "$ssid" ] && continue
    
    # Extract signal strength - it's always a number, so find the first one
    signal=$(echo "$network" | grep -oE '[0-9]+' | head -1)
    
    # Extract security - everything between SSID and SIGNAL
    security=$(echo "$network" | sed 's/^[^ ]* //; s/ [0-9].*//')
    
    # Determine if this is the current connection
    if [ "$ssid" = "$current_connection" ]; then
        icon="󰤨"  # Connected
        status="Connected"
    else
        # Choose icon based on signal strength
        if [ -n "$signal" ] && [ "$signal" -ge 75 ]; then
            icon="󰤨"
        elif [ -n "$signal" ] && [ "$signal" -ge 50 ]; then
            icon="󰤥"
        elif [ -n "$signal" ] && [ "$signal" -ge 25 ]; then
            icon="󰤢"
        else
            icon="󰤟"
        fi
        status=""
    fi
    
    # Add security indicator
    if [[ "$security" == *"WPA"* ]] || [[ "$security" == *"WEP"* ]]; then
        security_icon="	󰌾"
    else
        security_icon=""
    fi
    
    # Build menu item
    if [ -n "$status" ]; then
        menu_items+=("$icon	$ssid$security_icon ($status)")
    else
        menu_items+=("$icon	$ssid$security_icon")
    fi
    ssid_list+=("$ssid")
done

# Add management options
menu_items+=("---")
menu_items+=("󰑓	Rescan Networks")
menu_items+=("󰖪	Turn WiFi Off")
menu_items+=("󰍺	Network Settings")

# Show menu
choice=$(printf '%s\n' "${menu_items[@]}" | $MENU)

# Handle choice
if [ -z "$choice" ]; then
    exit 0
fi

# Find selected network index
for i in "${!menu_items[@]}"; do
    if [ "${menu_items[$i]}" = "$choice" ]; then
        selected_index=$i
        break
    fi
done

# Handle network selection
if [ -n "$selected_index" ] && [ "$selected_index" -lt ${#ssid_list[@]} ]; then
    ssid="${ssid_list[$selected_index]}"
    
    # Check if this is the current connection
    if [ "$ssid" = "$current_connection" ]; then
        # Disconnect
        nmcli connection down "$ssid"
        notify-send "WiFi" "Disconnected from $ssid" -i network-wireless-disconnected
    else
        # Try to connect
        notify-send "WiFi" "Connecting to $ssid..." -i network-wireless
        
        # Check if we have a saved connection
        if nmcli connection show "$ssid" &>/dev/null; then
            # Use saved connection
            if nmcli connection up "$ssid"; then
                notify-send "WiFi" "Connected to $ssid" -i network-wireless
            else
                notify-send "WiFi" "Failed to connect to $ssid" -i dialog-error
            fi
        else
            # New network - check if it requires password
            network_info=$(nmcli -f SSID,SECURITY device wifi list | grep "^$ssid")
            if echo "$network_info" | grep -qE "WPA|WEP"; then
                # Ask for password
                password=$($MENU_PASS)
                if [ -n "$password" ]; then
                    if nmcli device wifi connect "$ssid" password "$password"; then
                        notify-send "WiFi" "Connected to $ssid" -i network-wireless
                    else
                        notify-send "WiFi" "Failed to connect to $ssid (incorrect password?)" -i dialog-error
                    fi
                fi
            else
                # Open network
                if nmcli device wifi connect "$ssid"; then
                    notify-send "WiFi" "Connected to $ssid" -i network-wireless
                else
                    notify-send "WiFi" "Failed to connect to $ssid" -i dialog-error
                fi
            fi
        fi
    fi
    pkill -RTMIN+9 waybar
elif [[ "$choice" == *"Rescan"* ]]; then
    notify-send "WiFi" "Scanning for networks..." -i network-wireless
    nmcli device wifi rescan
    sleep 2
    exec "$0"
elif [[ "$choice" == *"Turn WiFi Off"* ]]; then
    nmcli radio wifi off
    notify-send "WiFi" "Disabled" -i network-wireless-disabled
    pkill -RTMIN+9 waybar
elif [[ "$choice" == *"Network Settings"* ]]; then
    if command -v nm-connection-editor &> /dev/null; then
        nm-connection-editor &
    else
        notify-send "Error" "Network settings not found"
    fi
fi
