#!/bin/bash
# Update dependency
pip install --upgrade asttokens
# Installs Vyper, Ape Vyper, Py-solc-x, Pyevwasm
python3.9 -m pip install ape-vyper \ 
pyevmasm \
py-solc-x \
vyper
