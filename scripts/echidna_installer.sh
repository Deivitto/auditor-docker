#!/bin/bash
# Initial comment code is working
echo "Installing brew and echidna..."
# Export keywords
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
# Start brew installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/whitehat/.bashrc  && \
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
# Use brew to install last version of echidna
brew install --HEAD echidna && \
# End configuration
brew postinstall echidna
# Source it
source ~/.bashrc
# Confirmation message
echo "Installation completed! Open a new bash or source ~/.bashrc in order to use echidna"
