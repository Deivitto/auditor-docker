#!/bin/bash

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
    "vyper --version"

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
    "medusa --version"
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
