#!/bin/bash

# Go home
cd $HOME

# Create a virtual environment for Manticore
python3.9 -m venv .manticore_env

# Activate the virtual environment
source .manticore_env/bin/activate

# Install Manticore with native dependencies
pip3 install manticore[native]

# Install the specific version of protobuf
pip3 install protobuf==3.19.5

# Deactivate the virtual environment after installation
deactivate

# Create symbolic links in ~/.local/bin for manticore and etheno
ln -sf /home/whitehat/.manticore_env/bin/manticore ~/.local/bin/manticore

echo "Manticore installation complete. Use the 'manticore' command to run Manticore within the virtual environment."
