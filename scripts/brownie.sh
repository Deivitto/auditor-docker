#!/bin/bash

# Go home
cd $HOME

# Create a virtual environment for Eth Brownie
python3.9 -m venv .brownie_env

# Activate the virtual environment
source .brownie_env/bin/activate

# Install Eth Brownie with native dependencies
pip3 install eth-brownie

# Deactivate the virtual environment after installation
deactivate

# Create symbolic links in ~/.local/bin 

ln -sf /home/whitehat/.brownie_env/bin/brownie ~/.local/bin/brownie

echo "Brownie installed. Use the 'brownie' command to run Eth-Brownie."
