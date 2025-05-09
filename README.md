# Dotfiles

This repository contains my personal dotfiles and configuration files managed using GNU Stow. These dotfiles help maintain consistent development environments across different machines.

## 🔧 Tools & Configurations

- **AWS**: AWS CLI configuration
- **Git**: Git configuration and aliases
- **Maven**: Maven build tool configuration
- **SSH**: SSH configuration
- **Starship**: Starship prompt customization
- **Zed**: Zed editor configuration
- **ZSH**: Shell configuration and customization

## 📦 Prerequisites

- GNU Stow
- Git

## 🚀 Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/daviseagull/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Set up ZSH to use XDG config directory:

   ```bash
   # Create .zshenv in home directory
   cat > ~/.zshenv << 'EOL'
   # XDG Base Directory Specification
   export XDG_CONFIG_HOME="$HOME/.config"
   export XDG_CACHE_HOME="$HOME/.cache"
   export XDG_DATA_HOME="$HOME/.local/share"
   export XDG_STATE_HOME="$HOME/.local/state"

   # ZSH specific
   export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
   export HISTFILE="$XDG_STATE_HOME/zsh/history"
   export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
   export ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION"
   EOL

   ```

3. Use Stow to create symlinks:

   ```bash
   stow .
   ```

   This will automatically create symlinks in your `~/.config` directory for all configurations.

## 📂 Structure

The repository is organized by tool/application, with each directory containing related configuration files:

```
dotfiles/
├── aws/         # AWS CLI configuration
├── git/         # Git configuration
├── maven/       # Maven configuration
├── ssh/         # SSH configuration
├── starship/    # Starship prompt configuration
├── zed/         # Zed editor configuration
└── zsh/         # ZSH shell configuration
```

## ⚙️ Configuration

The `.stowrc` file is configured to:

- Target the `~/.config` directory for symlinks
- Ignore `.stowrc` and `DS_STORE` files
