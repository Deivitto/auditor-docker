#!/bin/bash

# Go home
cd $HOME

# Create a virtual environment for Manticore
python3.9 -m venv .manticore_env

# Activate the virtual environment
source .manticore_env/bin/activate

# Install Manticore with native dependencies
pip3 install manticore[native] etheno eth-brownie

# Deactivate the virtual environment after installation
deactivate

# Create symbolic links in ~/.local/bin for manticore and etheno
ln -sf /home/whitehat/.manticore_env/bin/manticore ~/.local/bin/manticore
ln -sf /home/whitehat/.manticore_env/bin/etheno ~/.local/bin/etheno
ln -sf /home/whitehat/.manticore_env/bin/brownie ~/.local/bin/brownie

echo "Manticore installation complete. Use the 'manticore' command to run Manticore within the virtual environment."
echo "Etheno installed too. Use the 'etheno' command to run Etheno."
echo "Brownie installed. Use the 'brownie' command to run Eth-Brownie."
echo "Globally installing embark..."

# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \
