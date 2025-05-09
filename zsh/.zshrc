alias dev='cd ~/Developer'
alias personal='cd ~/Developer/personal'
alias mmscan='cd ~/Developer/MMSCAN'

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $XDG_DATA_HOME/oh-my-zsh/oh-my-zsh.sh
eval "$(starship init zsh)"

# Private configurations (if they exist)
[[ -f ~/.config/zsh/private.zsh ]] && source ~/.config/zsh/private.zsh
[[ -f ~/.config/zsh/local.zsh ]] && source ~/.config/zsh/local.zsh
