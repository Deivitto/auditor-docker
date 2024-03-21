#!/bin/bash

# Remove old version
echo "Removing old version of Medusa..."
sudo rm /usr/local/bin/medusa

# Download the Source Code
echo "Downloading Medusa..."
wget https://github.com/crytic/medusa/releases/download/v0.1.3/medusa-linux-x64.tar.gz -O medusa.tar.gz

# Extract the Downloaded Archive
echo "Extracting Medusa..."
tar -xvf medusa.tar.gz

# Move the Binary to /usr/local/bin/
echo "Moving Medusa binary to /usr/local/bin/"
sudo mv medusa /usr/local/bin/

# Make the Binary Executable
echo "Making Medusa executable..."
sudo chmod +x /usr/local/bin/medusa

# Cleaning up the downloaded and extracted files
echo "Cleaning up..."
rm medusa.tar.gz

echo "Medusa installation complete! You can now use the 'medusa' command from the terminal."

