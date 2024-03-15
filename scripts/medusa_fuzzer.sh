#!/bin/bash

# Download the Source Code
echo "Downloading Medusa..."
wget https://github.com/crytic/medusa/releases/download/v0.1.3/medusa-linux-x64.zip -O medusa.zip

# Extract the Downloaded Archive
echo "Extracting Medusa..."
unzip medusa.zip

# Move the Binary to /usr/local/bin/
echo "Moving Medusa binary to /usr/local/bin/"
sudo mv medusa /usr/local/bin/

# Make the Binary Executable
echo "Making Medusa executable..."
sudo chmod +x /usr/local/bin/medusa

# Cleaning up the downloaded and extracted files
echo "Cleaning up..."
rm medusa.zip

echo "Medusa installation complete! You can now use the 'medusa' command from the terminal."

