#!/bin/bash

# Theme switcher for Ghostty, TMUX, and NeoVim
# Supports Catppuccin theme variants

set -e

DOTFILES_DIR="$HOME/Developer/personal/dotfiles"
GHOSTTY_CONFIG="$DOTFILES_DIR/ghostty/config"
TMUX_CONFIG="$DOTFILES_DIR/tmux/tmux.conf"
NVIM_THEME_CONFIG="$DOTFILES_DIR/nvim/lua/plugins/catppuccin.lua"

# Function to get theme configuration
get_theme_config() {
    case $1 in
        # Catppuccin themes
        "catppuccin-latte") echo "catppuccin-latte,latte,catppuccin-latte" ;;
        "catppuccin-frappe") echo "catppuccin-frappe,frappe,catppuccin-frappe" ;;
        "catppuccin-macchiato") echo "catppuccin-macchiato,macchiato,catppuccin-macchiato" ;;
        "catppuccin-mocha") echo "catppuccin-mocha,mocha,catppuccin-mocha" ;;
        *) echo "" ;;
    esac
}

# Function to show available themes
show_themes() {
    echo "Available Catppuccin themes:"
    echo "  1) catppuccin-latte (light)"
    echo "  2) catppuccin-frappe (dark)"
    echo "  3) catppuccin-macchiato (dark)"
    echo "  4) catppuccin-mocha (dark)"
    echo
}

# Function to update Ghostty theme
update_ghostty_theme() {
    local theme=$1
    echo "Updating Ghostty theme to: $theme"
    sed -i '' "s/^theme = .*/theme = $theme/" "$GHOSTTY_CONFIG"
}

# Function to update TMUX theme
update_tmux_theme() {
    local variant=$1
    echo "Updating TMUX theme to catppuccin ($variant)"
    sed -i '' "s/@catppuccin_flavour '[^']*'/@catppuccin_flavour '$variant'/" "$TMUX_CONFIG"
}

# Function to update NeoVim theme
update_neovim_theme() {
    local theme=$1
    echo "Updating NeoVim theme to: $theme"
    sed -i '' "s/colorscheme = \"[^\"]*\"/colorscheme = \"$theme\"/" "$NVIM_THEME_CONFIG"
}

# Function to reload configurations
reload_configs() {
    echo "Reloading configurations..."
    
    # Reload TMUX config if tmux is running
    if pgrep -x "tmux" > /dev/null; then
        echo "Reloading tmux configuration..."
        tmux source-file "$TMUX_CONFIG" 2>/dev/null || echo "Note: Could not reload tmux config automatically"
        
        # Force refresh all tmux windows
        tmux refresh-client -S 2>/dev/null || true
        
        echo "TMUX theme updated. If theme didn't change, try:"
        echo "  - Press prefix + I to install/update plugins"
        echo "  - Or restart tmux sessions"
    fi
    
    echo "Theme switching complete!"
    echo "Note: You may need to restart Ghostty and NeoVim to see the changes"
}

# Main function
main() {
    local selected_theme=""
    
    if [ $# -eq 0 ]; then
        show_themes
        echo "Please select a theme by number or name:"
        read -r selection
        
        case $selection in
            1) selected_theme="catppuccin-latte" ;;
            2) selected_theme="catppuccin-frappe" ;;
            3) selected_theme="catppuccin-macchiato" ;;
            4) selected_theme="catppuccin-mocha" ;;
            *) selected_theme="$selection" ;;
        esac
    else
        selected_theme="$1"
    fi
    
    # Get theme configuration
    theme_config=$(get_theme_config "$selected_theme")
    if [[ -z "$theme_config" ]]; then
        echo "Error: Invalid theme '$selected_theme'"
        show_themes
        exit 1
    fi
    
    # Parse theme configuration
    IFS=',' read -r ghostty_theme tmux_variant nvim_theme <<< "$theme_config"
    
    echo "Switching to theme: $selected_theme"
    echo "----------------------------------------"
    
    # Update each application's theme
    update_ghostty_theme "$ghostty_theme"
    update_tmux_theme "$tmux_variant"
    update_neovim_theme "$nvim_theme"
    
    # Reload configurations
    reload_configs
}

# Run the script
main "$@"