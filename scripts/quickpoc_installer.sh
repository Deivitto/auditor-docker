#!/bin/bash

# Define your actual RPC URL and Etherscan API Key here
ETH_RPC_URL="YOUR_ETH_RPC_URL"
ETHERSCAN_API_KEY="YOUR_ETHERSCAN_API_KEY"

# Install jq if it's not already present
if ! command -v jq &>/dev/null; then
    echo "Installing jq..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        curl -L -o jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-osx-amd64
    else
        echo "Unsupported OS for automatic jq installation"
        exit 1
    fi
    chmod +x ./jq
    mv jq /usr/local/bin
else
    echo "jq is already installed."
fi

# Clone quickpoc repository
git clone https://github.com/zobront/quickpoc.git

# Create .quickpoc directory and copy the quickpoc script
mkdir -p $HOME/.quickpoc/bin
cp quickpoc/quickpoc $HOME/.quickpoc/bin/quickpoc

# Set up environment variables
echo "export ETH_RPC_URL=\"$ETH_RPC_URL\"" >> $HOME/.profile
echo "export ETHERSCAN_API_KEY=\"$ETHERSCAN_API_KEY\"" >> $HOME/.profile

# Add the .quickpoc/bin directory to PATH
echo 'export PATH="$PATH:$HOME/.quickpoc/bin"' >> $HOME/.profile

# Make quickpoc script executable
chmod +x $HOME/.quickpoc/bin/quickpoc

# Source the .profile to update environment variables and PATH
source $HOME/.profile

# Completion message
echo "quickpoc installation complete. You can now use 'quickpoc 0x...' from any folder."

# Reminder to replace placeholders
echo "Please ensure you replace the ETH_RPC_URL and ETHERSCAN_API_KEY in your .profile with actual values."
