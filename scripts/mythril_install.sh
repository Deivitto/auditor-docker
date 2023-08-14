#!/bin/bash
# Go home
cd /home/whitehat

# Create a venv just for mythril
python3.9 -m venv .mythril_env

# Source the env
source .mythril_env/bin/activate
    
# This next line fixes some wrong installations
pip install --upgrade pip 

# Install mythril
pip install mythril

# Deactivate after use
deactivate

# Create an "alias" what is actually a function in the bashrc so the whole process of using the venv is transparent
echo -e 'function myth() {\n
    source $(pwd)/.mythril_env/bin/activate\n
    command myth "$@"\n
    deactivate\n
}' >> ~/.bashrc

# Source bashrc for the use cases
source ~/.bashrc

# Installed
echo "Mythril installation complete. Use the 'myth' command to run Mythril within the virtual environment."
    
