#!/bin/bash

############################
# Rose Pine Moon SDDM Theme
# Installation Script
############################

echo "🌙 Installing Rose Pine Moon SDDM Theme..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ This script must be run as root (use sudo)"
    echo "Usage: sudo ./install-sddm-theme.sh"
    exit 1
fi

# Colors
IRIS='\033[0;35m'
FOAM='\033[0;36m'
ROSE='\033[0;31m'
GOLD='\033[0;33m'
NC='\033[0m'

THEME_DIR="/usr/share/sddm/themes/rose-pine-moon"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/sddm-rose-pine-moon"

echo ""
echo -e "${IRIS}📦 Installing theme files...${NC}"

# Create theme directory
mkdir -p "$THEME_DIR"

# Copy theme files
cp -r "$SOURCE_DIR"/* "$THEME_DIR/"
chmod -R 755 "$THEME_DIR"

echo -e "${FOAM}✓${NC} Theme files copied to $THEME_DIR"

echo ""
echo -e "${IRIS}⚙️  Configuring SDDM...${NC}"

# Create sddm.conf.d directory if it doesn't exist
mkdir -p /etc/sddm.conf.d

# Create or update configuration
cat > /etc/sddm.conf.d/rose-pine-moon.conf <<EOF
[Theme]
Current=rose-pine-moon
CursorTheme=rose-pine-hyprcursor

[General]
DisplayServer=wayland
GreeterEnvironment="QT_WAYLAND_SHELL_INTEGRATION=layer-shell"
InputMethod=
EOF

echo -e "${FOAM}✓${NC} SDDM configuration updated"

echo ""
echo -e "${IRIS}🎨 Customization options:${NC}"
echo ""
echo "To use a custom background image:"
echo "  1. Copy your image to: $THEME_DIR/background.png"
echo "  2. Or edit: $THEME_DIR/theme.conf"
echo ""
echo "To adjust theme settings:"
echo "  Edit: $THEME_DIR/Main.qml"
echo ""

echo -e "${IRIS}✨ Installation complete!${NC}"
echo ""
echo "The Rose Pine Moon theme will be used on next boot."
echo ""
echo "To test the theme now (will show SDDM greeter):"
echo "  sddm-greeter --test-mode --theme $THEME_DIR"
echo ""
echo "To revert to default theme:"
echo "  sudo rm /etc/sddm.conf.d/rose-pine-moon.conf"
echo ""
