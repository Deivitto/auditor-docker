#!/bin/bash

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
    echo "Directory .pyrometer already exists. Please remove or rename it and try again."
    exit 1
fi
git clone https://github.com/nascentxyz/pyrometer .pyrometer

# Navigate to the cli directory
echo "Navigating to the Pyrometer CLI directory..."
cd .pyrometer/cli

# Install using cargo
echo "Installing Pyrometer using Cargo..."
cargo install --path . --locked

# Inform the user about the next steps
echo "Pyrometer installation complete!"
echo "Usage:"
echo "  pyrometer <PATH_TO_SOLIDITY_FILE> --help"
echo "Quick Tips:"
echo "  pyrometer ./myContract.sol --remappings remappings.txt  # Use the --remappings flag if your project imports contracts via node_modules or uses remappings."
echo "  pyrometer ./myContract.sol -vv  # -vv is a good verbosity level."
echo "  pyrometer ./myContract.sol --funcs \"myFunc\"  # Filter the output for a specific function."
echo "  pyrometer ./myContract.sol --contracts \"myContract\"  # Filter the output for a specific contract."
