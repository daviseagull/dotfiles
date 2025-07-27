# STARSHIP
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# GIT
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME}/git/config"

# MAVEN
export MAVEN_HOME="${XDG_CONFIG_HOME}/maven"
export MAVEN_SETTINGS="${XDG_CONFIG_HOME}/maven/settings.xml"
export MAVEN_USER_HOME="${XDG_CONFIG_HOME}/maven"

# JDK
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH="$JAVA_HOME/bin:$PATH"

# NVM
export NVM_DIR="$XDG_CONFIG_HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# PNPM
export PNPM_HOME="/Users/seagull/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
