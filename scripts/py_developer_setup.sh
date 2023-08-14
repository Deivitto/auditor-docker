#!/bin/bash

# Ensure we have a clean start
pip3 uninstall -y asttokens vyper pyevmasm py-solc-x ape-vyper

# Install asttokens at version 2.0.5 first as required by Vyper
pip3 install asttokens==2.0.5

# Then install Vyper and the other packages
python3.9 -m pip install vyper ape-vyper pyevmasm py-solc-x

