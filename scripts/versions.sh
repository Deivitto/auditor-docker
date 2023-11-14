#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# List of commands to check
commands=(
    "forge --version"
    "slither --version"
    "issue -h"
    "cargo --version"
    "halmos --version"
    "heimdall --version"
    "python3.9 --version"
    "pip3 --version"
    "solc-select -h"
    "ganache --version"
    "truffle --version"
    "julia --version"
    "npm --version"
    "nvm ls"
    "yarn --version"
    "solc --version"
    "anvil -h"
    "cast -h"
    "chisel -h"
    "cargo -h"
    "cargo-clippy -h"
    "cargo-fmt -h"
    "clippy-driver -h"
# installer
    "certoraRun --version"
    "manticore --version"
    "etheno --version"
    "brownie --version"
    "certoraRun -h"
    "circom --version"
    "analyze4 -h"
    "nargo -h"
    "myth -h"
    "medusa --version"
    "pyrometer --version"
    "vyper --version"
    "ape -h"
    "evmasm -h"
    "pytest -h"
    "echidna --version"
    "quickpoc -h"
)

# Check each command
for cmd in "${commands[@]}"; do
    echo "Testing $cmd..."
    $cmd > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "✅ $cmd is available."
    else
        echo "❌ $cmd is NOT available."
    fi
done
