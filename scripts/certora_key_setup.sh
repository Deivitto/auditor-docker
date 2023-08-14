#!/bin/bash

# First param will be the key
export CERTORAKEY=$1

# Export to bashrc the cerora key
echo "export CERTORAKEY=\$CERTORAKEY" >> ~/.bashrc

# Source it
source ~/.bashrc

# Confirmation message
echo "Certora key has been set up."
    
