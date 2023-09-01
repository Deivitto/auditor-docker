#!/bin/bash

# Ensure the script stops if any command fails
set -e

echo "Executing all scripts..."

~/scripts/analyzer_installer.sh
~/scripts/brownie.sh
~/scripts/certora_key_setup.sh
~/scripts/certora_setup.sh
~/scripts/circom_setup.sh
~/scripts/etheno.sh
~/scripts/manticore.sh
~/scripts/medusa_fuzzer.sh
~/scripts/mythril_install.sh
~/scripts/noir_setup.sh
~/scripts/pyrometer_installer.sh
~/scripts/py_developer_setup.sh
~/scripts/embark.sh
~/scripts/echidna_installer.sh

echo "All scripts executed successfully!"
