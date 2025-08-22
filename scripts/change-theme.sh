#!/bin/bash

# Theme switcher for Ghostty, TMUX, and NeoVim
# Rose Pine theme variants

set -e

DOTFILES_DIR="$HOME/Developer/personal/dotfiles"
GHOSTTY_CONFIG="$DOTFILES_DIR/ghostty/config"
TMUX_CONFIG="$DOTFILES_DIR/tmux/tmux.conf"
NVIM_THEME_CONFIG="$DOTFILES_DIR/nvim/lua/plugins/rose-pine.lua"

# Function to get theme configuration
get_theme_config() {
    case $1 in
        "rose-pine-main") echo "rose-pine,main,rose-pine" ;;
        "rose-pine-moon") echo "rose-pine-moon,moon,rose-pine-moon" ;;
        "rose-pine-dawn") echo "rose-pine-dawn,dawn,rose-pine-dawn" ;;
        *) echo "" ;;
    esac
}

# Function to show available themes
show_themes() {
    echo "Available Rose Pine themes:"
    echo "  1) rose-pine-main"
    echo "  2) rose-pine-moon" 
    echo "  3) rose-pine-dawn"
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
    echo "Updating TMUX theme to rose-pine ($variant)"
    sed -i '' "s/@rose_pine_variant '[^']*'/@rose_pine_variant '$variant'/" "$TMUX_CONFIG"
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
            1) selected_theme="rose-pine-main" ;;
            2) selected_theme="rose-pine-moon" ;;
            3) selected_theme="rose-pine-dawn" ;;
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