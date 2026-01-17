# Path to oh-my-zsh installation
export ZSH="$HOME/.config/zsh/ohmyzsh"

# Theme (disabled in favor of Starship)
ZSH_THEME=""

plugins=(
  git
  gradle
  opentofu
  podman
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
  starship
)

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Private configurations (if they exist)
[[ -f ~/.config/zsh/private.zsh ]] && source ~/.config/zsh/private.zsh
[[ -f ~/.config/zsh/local.zsh ]] && source ~/.config/zsh/local.zsh

# Source aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh


# opencode
export PATH=/home/gull/.opencode/bin:$PATH
