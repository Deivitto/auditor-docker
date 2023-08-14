#!/bin/bash
# Go home
cd /home/whitehat

mkdir .manticore_env
# Create a virtual environment for Manticore
python3.9 -m venv .manticore_env

# Activate the virtual environment
source .manticore_env/bin/activate

# Install Manticore with native dependencies
pip3 install manticore[native] etheno eth-brownie

# Deactivate the virtual environment after installation
deactivate

# Append a function to .bashrc for easy usage of Manticore within its virtual environment
echo -e 'function manticore() {\n
    source $(pwd)/.manticore_env/bin/activate\n
    command manticore "$@"\n
    deactivate\n
}' >> ~/.bashrc

echo -e 'function etheno() {\n
    source $(pwd)/.manticore_env/bin/activate\n
    command etheno "$@"\n
    deactivate\n
}' >> ~/.bashrc


# Source .bashrc to reflect the changes
source ~/.bashrc

echo "Manticore installation complete. Use the 'manticore' command to run Manticore within the virtual environment."
echo "Etheno installed too. Globally installing embark"
# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \
