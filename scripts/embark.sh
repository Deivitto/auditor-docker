#!/bin/bash

# Go home
cd $HOME

echo "Globally installing embark..."

nvm install 16 

nvm use 16
# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \