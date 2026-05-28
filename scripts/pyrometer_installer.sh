#!/bin/bash
set -euo pipefail

# Ensure the CARGO_HOME/bin is in your PATH.
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
    echo "Adding cargo bin directory to PATH in ~/.bashrc..."
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi

# Clone the Pyrometer repository
echo "Cloning the Pyrometer repository..."
cd $HOME
if [ -d ".pyrometer" ]; then
    rm -rf .pyrometer
fi
git clone https://github.com/nascentxyz/pyrometer .pyrometer

# Install using cargo
echo "Installing Pyrometer using Cargo..."
cargo install --path .pyrometer/crates/cli --locked

# Inform the user about the next steps
echo "Pyrometer installation complete!"
echo "Usage:"
echo "  pyrometer <PATH_TO_SOLIDITY_FILE> --help"
echo "Quick Tips:"
echo "  pyrometer ./myContract.sol --remappings remappings.txt  # Use the --remappings flag if your project imports contracts via node_modules or uses remappings."
echo "  pyrometer ./myContract.sol -vv  # -vv is a good verbosity level."
echo "  pyrometer ./myContract.sol --funcs \"myFunc\"  # Filter the output for a specific function."
echo "  pyrometer ./myContract.sol --contracts \"myContract\"  # Filter the output for a specific contract."
