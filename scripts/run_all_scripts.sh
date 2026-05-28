#!/bin/bash
set -euo pipefail

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"

echo "Executing all scripts..."

~/scripts/analyzer_installer.sh
~/scripts/brownie.sh
~/scripts/certora_setup.sh
~/scripts/circom_setup.sh
~/scripts/etheno.sh
~/scripts/manticore.sh
~/scripts/medusa_fuzzer.sh
~/scripts/mythril_install.sh
~/scripts/noir_setup.sh
~/scripts/pyrometer_installer.sh
~/scripts/py_developer_setup.sh
~/scripts/quickpoc_installer.sh
~/scripts/echidna_installer.sh

echo "All scripts executed successfully!"
