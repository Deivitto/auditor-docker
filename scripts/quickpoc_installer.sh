#!/bin/bash
set -euo pipefail

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
    sudo mv jq /usr/local/bin/jq
else
    echo "jq is already installed."
fi

# Clone quickpoc repository
cd $HOME
rm -rf quickpoc
git clone https://github.com/zobront/quickpoc.git

# Create .quickpoc directory and copy the quickpoc script
mkdir -p $HOME/.quickpoc/bin
cp quickpoc/quickpoc $HOME/.quickpoc/bin/quickpoc-real
cat > $HOME/.quickpoc/bin/quickpoc <<'EOL'
#!/bin/bash
set -euo pipefail

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    /home/whitehat/.quickpoc/bin/quickpoc-real 2>&1 || true
    exit 0
fi

exec /home/whitehat/.quickpoc/bin/quickpoc-real "$@"
EOL

# Set up environment variables
echo "export ETH_RPC_URL=\"$ETH_RPC_URL\"" >> $HOME/.profile
echo "export ETHERSCAN_API_KEY=\"$ETHERSCAN_API_KEY\"" >> $HOME/.profile

# Add the .quickpoc/bin directory to PATH
echo 'export PATH="$PATH:$HOME/.quickpoc/bin"' >> $HOME/.profile

# Make quickpoc script executable
chmod +x $HOME/.quickpoc/bin/quickpoc $HOME/.quickpoc/bin/quickpoc-real
ln -sf $HOME/.quickpoc/bin/quickpoc $HOME/.local/bin/quickpoc

# Source the .profile to update environment variables and PATH
source $HOME/.profile

# Completion message
echo "quickpoc installation complete. You can now use 'quickpoc 0x...' from any folder."

# Reminder to replace placeholders
echo "Please ensure you replace the ETH_RPC_URL and ETHERSCAN_API_KEY in your .profile with actual values."
