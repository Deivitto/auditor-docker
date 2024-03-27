#!/bin/bash
# Installing echidna
echo "[$(date)] Install echidna"
# Getting bin version (THIS VERSION IS HARDCODED)
wget https://github.com/crytic/echidna/releases/download/v2.2.2/echidna-2.2.2-x86_64-linux.tar.gz -O echidna.tar.gz
# Uncompressing
tar -xvkf echidna.tar.gz
# Moving to binaries folder for the access
sudo mv echidna /usr/bin/
# Removing local compressed file
rm echidna.tar.gz

