#!/bin/bash

# Step 1: Clone the repository and install its dependencies
echo "Cloning 4naly3er repository..."
git clone https://github.com/Picodes/4naly3er .4nalyz3r

echo "Installing dependencies..."
cd .4nalyz3r && yarn

# Step 2: Create the 4nalyz3r script inside ~/scripts
SCRIPT_PATH="${HOME}/scripts/4nalyz3r"
echo "Creating 4nalyz3r script at ${SCRIPT_PATH}..."

mkdir -p ~/scripts
touch $SCRIPT_PATH
chmod +x $SCRIPT_PATH

cat > $SCRIPT_PATH <<EOL
#!/bin/bash

BASE_DIR="\$(pwd)"
SCOPE_FILE_DEFAULT="scope.txt"
SCRIPT_DIR="${HOME}/.4nalyz3r"

# Check for foundry.toml in the current directory
if [[ -f "\${BASE_DIR}/foundry.toml" ]]; then
    echo "foundry.toml detected. Initializing submodules and running forge build."
    git submodule update --init --recursive
    forge build
fi

# Check for -h or no arguments
if [[ "\$1" == "-h" ]] || [[ -z "\$1" ]]; then
    echo "Usage: analyze4 <BASE_PATH> [SCOPE_FILE] [GITHUB_URL]"
    echo "Example: analyze4 contracts scope.example.txt"
    exit 0
fi

BASE_PATH="\${BASE_DIR}/\$1"
SCOPE_FILE_PATH="\$2"

# If SCOPE_FILE is not provided and a default scope file exists, use it
if [[ -z "\$SCOPE_FILE_PATH" ]] && [[ -f "\${BASE_DIR}/\${SCOPE_FILE_DEFAULT}" ]]; then
    SCOPE_FILE_PATH="\${BASE_DIR}/\${SCOPE_FILE_DEFAULT}"
fi

GITHUB_URL="\$3"

# Change to the script directory and run yarn analyze
cd \$SCRIPT_DIR
yarn analyze "\$BASE_PATH" "\$SCOPE_FILE_PATH" "\$GITHUB_URL"
EOL

# Step 3: Add the analyze4 alias to ~/.bashrc and source it
echo "Adding alias to ~/.bashrc..."
echo 'alias analyze4="~/scripts/4nalyz3r"' >> ~/.bashrc

echo "Sourcing ~/.bashrc..."
source ~/.bashrc

echo "Installation complete! You can now use analyze4 command."

