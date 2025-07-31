# Private configurations (if they exist)
[[ -f ~/.config/zsh/private.zsh ]] && source ~/.config/zsh/private.zsh
[[ -f ~/.config/zsh/local.zsh ]] && source ~/.config/zsh/local.zsh

# Source aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $XDG_DATA_HOME/oh-my-zsh/oh-my-zsh.sh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
