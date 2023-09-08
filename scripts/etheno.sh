#!/bin/bash

# Go home
cd $HOME

# Create a virtual environment for Etheno
python3.9 -m venv .etheno_env

# Activate the virtual environment
source .etheno_env/bin/activate

# Install Etheno with native dependencies
pip3 install etheno

# Deactivate the virtual environment after installation
deactivate

# Create symbolic links in ~/.local/bin for Etheno 

ln -sf /home/whitehat/.etheno_env/bin/etheno ~/.local/bin/etheno


echo "Etheno installed too. Use the 'etheno' command to run Etheno."
