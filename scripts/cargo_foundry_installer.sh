#!/bin/bash

curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
curl -L https://foundry.paradigm.xyz | bash
export PATH="~/.foundry/bin:${PATH}"
source ~/.bashrc
foundryup
