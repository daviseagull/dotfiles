# AWS
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# Starship
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# Git
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME}/git/config"

# Maven
export MAVEN_HOME="${XDG_CONFIG_HOME}/maven"
export MAVEN_USER_HOME="${XDG_CONFIG_HOME}/maven"
export MAVEN_CONFIG="${XDG_CONFIG_HOME}/maven/config"


# NVM
export NVM_DIR="$XDG_CONFIG_HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
