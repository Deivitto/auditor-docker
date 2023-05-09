#!/bin/bash
# Install OpenJDK 11 and set up Certora CLI
sudo apt-get update && sudo apt-get install -y openjdk-11-jdk && java -version && python3.9 -m pip install certora-cli
# Add solc path to the .profile file
cd ~ && echo "PATH=\$PATH:/home/whitehat/.local/bin/solc" >> ~/.profile && source ~/.profile
# Print completion message
echo "Certora setup complete. Use certoraKey to set up a new key."
