# AWS
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# Starship
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# Git
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME}/git/config"

# Maven
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
