#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Go home
cd $HOME

echo "Globally installing embark..."

nvm install 16 

nvm use 16
# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \
