#!/bin/bash
# Go home
cd /home/whitehat
# Clone circom into .circom
git clone https://github.com/iden3/circom.git .circom
# Cd in
cd .circom
# Launch circom commands
cargo build --release
cargo install --path circom
# Install snarkjs
npm install -g --omit=dev --global --force snarkjs 
