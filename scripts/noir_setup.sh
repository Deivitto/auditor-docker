#!/bin/bash
set -euo pipefail

# Installs Noir in .nargo folder
source ~/.cargo/env && \
# Creates the bin folder
mkdir -p $HOME/.nargo/bin && \
# Download the tar
curl -o $HOME/.nargo/bin/nargo-x86_64-unknown-linux-gnu.tar.gz -L https://github.com/noir-lang/noir/releases/download/v0.4.1/nargo-x86_64-unknown-linux-gnu.tar.gz && \
# Uncompress it
tar -xvf $HOME/.nargo/bin/nargo-x86_64-unknown-linux-gnu.tar.gz -C $HOME/.nargo/bin/ && \
# Save into the path
echo -e "\nexport PATH=$PATH:$HOME/.nargo/bin" >> ~/.bashrc && \
ln -sf $HOME/.nargo/bin/nargo $HOME/.local/bin/nargo && \
# Source to use nargo command
source ~/.bashrc
