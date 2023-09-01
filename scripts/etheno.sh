#!/bin/bash

# Go home
cd $HOME

# Create a virtual environment for Manticore
python3.9 -m venv .etheno_env

# Activate the virtual environment
source .etheno_env/bin/activate

# Install Manticore with native dependencies
pip3 install etheno

# Deactivate the virtual environment after installation
deactivate

# Create symbolic links in ~/.local/bin for manticore and etheno

ln -sf /home/whitehat/.etheno_env/bin/etheno ~/.local/bin/etheno


echo "Etheno installed too. Use the 'etheno' command to run Etheno."
