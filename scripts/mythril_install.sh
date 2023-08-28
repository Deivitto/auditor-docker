#!/bin/bash

# Go home
cd $HOME

# Create a venv just for mythril
python3.9 -m venv .mythril_env

# Source the env
source .mythril_env/bin/activate
    
# This next line fixes some wrong installations
python3.9 -m pip install --upgrade pip 

# Install wheel
python3.9 -m pip install wheel 

# Install mythril
python3.9 -m pip install mythril

# Deactivate after use
deactivate

# Create a symbolic link in ~/.local/bin for the myth command
ln -sf /home/whitehat/.mythril_env/bin/myth ~/.local/bin/myth

# Installed
echo "Mythril installation complete. Use the 'myth' command to run Mythril within the virtual environment."
