alias dev='cd ~/Developer'
alias personal='cd ~/Developer/personal'
alias mmscan='cd ~/Developer/mmscan'

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $XDG_DATA_HOME/oh-my-zsh/oh-my-zsh.sh
eval "$(starship init zsh)"

# Private configurations (if they exist)
[[ -f ~/.config/zsh/private.zsh ]] && source ~/.config/zsh/private.zsh
[[ -f ~/.config/zsh/local.zsh ]] && source ~/.config/zsh/local.zsh


# pnpm
export PNPM_HOME="/Users/seagull/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
