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

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# Private configurations (if they exist)
[[ -f ~/.config/zsh/private.zsh ]] && source ~/.config/zsh/private.zsh
[[ -f ~/.config/zsh/local.zsh ]] && source ~/.config/zsh/local.zsh

# Source aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

# YAZI Configuration
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
