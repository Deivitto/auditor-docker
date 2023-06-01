#!/bin/bash
git clone https://github.com/iden3/circom.git .circom
cd .circom
cargo build --release
cargo install --path circom
npm install -g --omit=dev --global --force snarkjs 
