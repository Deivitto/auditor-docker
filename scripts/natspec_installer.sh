#!/bin/bash

# Define the destination of the script and the symbolic link
script_path="$HOME/.local/share/natsmell.sh"
link_path="$HOME/.local/bin/natsmell"

# Create the bash script with help guide
cat << 'EOF' > "$script_path"
#!/bin/bash

# Function to display help
function display_help {
  echo "natsmell Usage Guide:"
  echo "-h           Display this help message."
  echo "-t [folder]  Set the target folder for inclusion (default: src)."
  echo "-l [number]  Set the number of levels to include in the path."
  echo "-e [folders] Set additional folders to exclude, separated by commas."
  echo "             Default excludes are 'test,scripts,script'."
  echo "-nano        Open the config file with nano after creation."
  echo "-vim         Open the config file with vim after creation."
  echo "-code        Open the config file with Visual Studio Code after creation."
  exit 0
}

# Default values
target_folder="src"
levels=""
excludes="test,scripts,script"
include_path="src/**/*.sol"
editor=""

# Parse arguments
while getopts "ht:l:e:nvc" opt; do
  case $opt in
    h) display_help
       ;;
    t) target_folder="$OPTARG"
       ;;
    l) levels="$OPTARG"
       ;;
    e) excludes="$OPTARG,$excludes"
       ;;
    n) editor="nano"
       ;;
    v) editor="vim"
       ;;
    c) editor="code"
       ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1
       ;;
  esac
done

# Adjust include path based on target folder and levels
if [ -n "$levels" ]; then
  include_path="${target_folder}"'/**'.{"${levels}"}'/*.sol'
else
  include_path="${target_folder}/**/*.sol"
fi

# Check if yarn natspec-smells is available
if ! yarn natspec-smells > natsmells.md 2>&1; then
  echo "natspec-smells not found, installing..."
  yarn add --dev @defi-wonderland/natspec-smells
  echo ""
  echo "Natspec Smells: Installation finished!"
  echo "- Step 1: Verify that natspec-smells.config.js has the expected configuration"
  echo "- Step 2: Run natsmell again or yarn natspec-smells"
  echo ""
  echo "For more options go to the main repository: https://github.com/defi-wonderland/natspec-smells?tab=readme-ov-file#options"
else
   echo "Smelling for missing natspec..."
   echo "Smells stored at natsmells.md"
fi

# Create natspec-smells.config.js
cat > natspec-smells.config.js << CONFIG
/**
 * List of supported options: https://github.com/defi-wonderland/natspec-smells?tab=readme-ov-file#options
 */

/** @type {import('@defi-wonderland/natspec-smells').Config} */
module.exports = {
  include: '${include_path}',
  exclude: '(${excludes})/**/*.sol',
};
CONFIG

# Open the config file with the selected editor, if any
if [ -n "$editor" ]; then
  $editor natspec-smells.config.js
fi
EOF

# Make the bash script executable
chmod +x "$script_path"

# Create a symbolic link
ln -sf "$script_path" "$link_path"

echo "natsmell has been installed successfully."
echo "You can use 'natsmell -h' to display the usage guide."
