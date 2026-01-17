# 🌙 Rose Pine Moon - Hyprland Setup

A minimalist and aesthetic Hyprland configuration using the Rose Pine Moon color palette.

## Preview

**Color Palette:** Rose Pine Moon
- Base: `#232136` - Primary background
- Surface: `#2a273f` - Secondary background  
- Text: `#e0def4` - Primary text
- Iris: `#c4a7e7` - Primary accent (workspaces, focus)
- Rose: `#ea9a97` - Secondary accent (important elements)
- Foam: `#9ccfd8` - Tertiary accent (info, media)
- Love: `#eb6f92` - Critical/errors
- Gold: `#f6c177` - Warnings

## Features

### Waybar
- **Floating bar** with rounded corners and blur effect
- **Minimalist modules:**
  - Workspaces (numbers only)
  - Window title (center)
  - Network status
  - Audio controls
  - Clock (12-hour format)
  - System tray
  - Media player (shows only when playing)
- **Transparency:** 85% opacity with 12px blur
- **Rose Pine Moon colors** throughout

### Hyprland
- **Border colors:** Iris → Rose gradient for active, highlight_med for inactive
- **Shadows:** Matching Rose Pine Moon base tones
- **Smooth animations** (preserved from original config)
- **Rofi launcher** instead of Wofi

### Hyprpaper
- Wallpaper daemon configuration
- Solid Rose Pine Moon color background
- Easy to customize with your own wallpapers

### Hyprlock
- **Lock screen** with Rose Pine Moon theme
- Blurred background with color overlay
- Time/date display
- Themed input field
- Visual feedback for auth states

### Swaync
- **Notification daemon** with Rose Pine Moon styling
- Rounded corners and blur
- Urgency level indicators
- Do Not Disturb widget
- Control center with notification history

### Rofi
- **Application launcher** with Rose Pine Moon theme
- Clean, minimalist design
- Icon support
- Fuzzy matching
- Matching Waybar aesthetic

## Installation

### Dependencies

```bash
# Arch Linux
sudo pacman -S waybar rofi hyprpaper hyprlock swaync playerctl imagemagick

# Fedora
sudo dnf install waybar rofi hyprpaper hyprlock swaync playerctl ImageMagick

# Ubuntu/Debian (some packages may need manual installation)
sudo apt install waybar rofi playerctl imagemagick
```

### Quick Setup

1. Clone or update your dotfiles:
```bash
cd ~/Developer/dotfiles
```

2. Run the setup script:
```bash
./setup-rose-pine.sh
```

This will:
- Check dependencies
- Create a Rose Pine Moon wallpaper
- Symlink all configurations
- Reload Hyprland components

### Manual Setup

If you prefer to set up manually or are using GNU Stow:

```bash
# Using stow
cd ~/Developer/dotfiles
stow waybar hypr swaync rofi

# Or copy manually
cp -r waybar ~/.config/
cp -r hypr/* ~/.config/hypr/
cp -r swaync ~/.config/
cp -r rofi ~/.config/

# Reload
hyprctl reload
killall waybar && waybar &
killall swaync && swaync &
killall hyprpaper && hyprpaper &
```

## Customization

### Waybar

**Module order:** Edit `waybar/config.jsonc`:
```jsonc
"modules-left": ["hyprland/workspaces", "custom/media"],
"modules-center": ["hyprland/window"],
"modules-right": ["network", "pulseaudio", "clock", "tray"]
```

**Colors:** Edit `waybar/style.css` - all Rose Pine Moon colors are defined at the top.

**Bar position:** Change `"position": "top"` to `"bottom"` in config.jsonc.

### Hyprland

**Border colors:** Edit `hypr/hyprland.conf`:
```conf
col.active_border = rgba(c4a7e7ee) rgba(ea9a97ee) 45deg  # iris -> rose
col.inactive_border = rgba(44415aaa)  # highlight_med
```

**Gaps:** Adjust in `hypr/hyprland.conf`:
```conf
gaps_in = 5
gaps_out = 20
```

### Wallpaper

**Solid color (default):**
The setup script creates `~/.config/hypr/rose-pine-moon-solid.png`.

**Custom wallpaper:**
1. Download from [Rose Pine wallpapers](https://github.com/rose-pine/wallpapers)
2. Update `hypr/hyprpaper.conf`:
```conf
preload = /path/to/your/wallpaper.png
wallpaper = DP-3,/path/to/your/wallpaper.png
```

**Gradient wallpaper:**
```bash
convert -size 1920x1080 gradient:"#232136-#2a273f" ~/.config/hypr/gradient.png
```

### Rofi

**Theme:** The Rose Pine Moon theme is at `rofi/rose-pine-moon.rasi`.

**Window size:** Edit `rofi/rose-pine-moon.rasi`:
```css
window {
    width: 600px;  /* Adjust width */
}

listview {
    lines: 8;  /* Number of visible items */
}
```

## Keybindings

Default Hyprland keybindings (from your config):

| Key | Action |
|-----|--------|
| `Super + Space` | Open Rofi launcher |
| `Super + T` | Open terminal (Ghostty) |
| `Super + Q` | Close window |
| `Super + V` | Clipboard history (cliphist) |
| `Super + H/J/K/L` | Move focus |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |

## Troubleshooting

### Waybar not showing
```bash
# Check if waybar is running
killall waybar
waybar

# Check for errors
waybar -l debug
```

### Media player not showing
The media module only shows when media is playing. Test with:
```bash
playerctl metadata
```

### Rofi theme not loading
```bash
# Test rofi
rofi -show drun

# Check theme
rofi-theme-selector
```

### Wallpaper not loading
```bash
# Check monitor name
hyprctl monitors

# Update hyprpaper.conf with correct monitor name
# Restart hyprpaper
killall hyprpaper && hyprpaper
```

### Notifications not themed
```bash
# Restart swaync
killall swaync && swaync

# Test notification
notify-send "Test" "Rose Pine Moon theme"
```

## File Structure

```
dotfiles/
├── waybar/
│   ├── config.jsonc      # Waybar configuration
│   └── style.css         # Rose Pine Moon styling
├── hypr/
│   ├── hyprland.conf     # Main Hyprland config (updated colors)
│   ├── hyprpaper.conf    # Wallpaper configuration
│   ├── hyprlock.conf     # Lock screen theme
│   └── hypridle.conf     # Idle configuration (unchanged)
├── swaync/
│   ├── config.json       # Notification daemon config
│   └── style.css         # Rose Pine Moon notifications
├── rofi/
│   ├── config.rasi       # Rofi configuration
│   └── rose-pine-moon.rasi  # Theme file
└── setup-rose-pine.sh    # Setup script
```

## Credits

- **Rose Pine:** [rosepinetheme.com](https://rosepinetheme.com)
- **Hyprland:** [hyprland.org](https://hyprland.org)
- **Waybar:** [github.com/Alexays/Waybar](https://github.com/Alexays/Waybar)

## License

These configurations are free to use and modify. Rose Pine theme is under MIT license.
