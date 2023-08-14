#!/bin/bash

cd /home/whitehat

# Create a virtual environment for Manticore
python3 -m venv .manticore_env

# Activate the virtual environment
source .manticore_env/bin/activate

# Install Manticore with native dependencies
pip3 install manticore[native]

python3.9 -m pip install     manticore     etheno     "eth-abi>=4.0.0"     "eth-account>=0.8.0"     "eth-hash[pycryptodome]>=0.5.1"     "eth-typing>=3.0.0"     "eth-utils>=2.1.0"     "crytic-compile>=0.3.1,<0.4.0"     "web3>=6.0.0" && \
# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \

# Deactivate the virtual environment after installation
deactivate

# Append a function to .bashrc for easy usage of Manticore within its virtual environment
echo -e 'function mcore() {\n\
    source $(pwd)/.manticore_env/bin/activate\n\
    command manticore "$@"\n\
    deactivate\n\
}' >> ~/.bashrc

# Source .bashrc to reflect the changes
source ~/.bashrc

echo "Manticore installation complete. Use the 'mcore' command to run Manticore within the virtual environment."



# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \
