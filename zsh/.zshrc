alias dev='cd ~/Developer'
alias personal='cd ~/Developer/personal'
alias mmscan='cd ~/Developer/MMSCAN'

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Private configurations (if they exist)
[[ -f ~/.config/zsh/private.zsh ]] && source ~/.config/zsh/private.zsh
[[ -f ~/.config/zsh/local.zsh ]] && source ~/.config/zsh/local.zsh
