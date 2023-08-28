#!/bin/bash

# Step 1: Clone the repository and install its dependencies
echo "Cloning 4naly3er repository..."
cd $HOME
git clone https://github.com/Picodes/4naly3er .4nalyz3r

echo "Installing dependencies..."
cd .4nalyz3r && yarn

# Step 2: Create the 4nalyz3r script inside ~/scripts
SCRIPT_PATH="${HOME}/scripts/4nalyz3r.sh"
echo "Creating 4nalyz3r script at ${SCRIPT_PATH}..."

mkdir -p ~/scripts
touch $SCRIPT_PATH
chmod +x $SCRIPT_PATH

cat > $SCRIPT_PATH <<EOL
#!/bin/bash

BASE_DIR="\$(pwd)"
SCOPE_FILE_DEFAULT="scope.txt"
SCRIPT_DIR="${HOME}/.4nalyz3r"
EDITOR_FLAG="code"  # Set 'code' as the default editor

# Help message function
display_help() {
    echo "Usage: analyze4 <BASE_PATH> [SCOPE_FILE.txt] [GITHUB_URL] [-vim|-nano|-d|-code]"
    echo
    echo "Parameters:"
    echo "  BASE_PATH        : The directory path you want to target."
    echo "  SCOPE_FILE.txt   : Path to a scope file (must be in .txt format)."
    echo "                     If not provided, the script will look for a 'scope.txt' in the current directory."
    echo "  GITHUB_URL       : A valid GitHub URL that starts with 'http://' or 'https://'."
    echo
    echo "Options:"
    echo "  -vim   : Open the report using Vim."
    echo "  -nano  : Open the report using Nano."
    echo "  -d     : Do not open the report."
    echo "  -code  : Open the report using Visual Studio Code (default behavior)."
    echo
    echo "Common Usage:"
    echo "  1. analyze4 src                          - When targeting the 'src' directory and no scope file provided."
    echo "  2. analyze4 contracts scope.other.txt    - When targeting the 'contracts' directory with a custom scope file."
    echo "  3. analyze4 .                            - When you're in the base root directory and targeting it."
    echo "  4. analyze4 src https://github.com/your/repo - When specifying a GitHub URL."
}

# Check if no arguments are provided or -h is used
if [[ \$# -eq 0 || "\$1" == "-h" ]]; then
    display_help
    exit 0
fi

while [[ \$# -gt 0 ]]; do
    case "\$1" in
        "-vim"|"-nano"|"-code")
            EDITOR_FLAG="\$1"
            shift
            ;;
        "-d")
            EDITOR_FLAG=""
            shift
            ;;
        *)
            if [[ -z "\$BASE_PATH" ]]; then
                BASE_PATH="\${BASE_DIR}/\$1"
            elif [[ "\$1" =~ ^https?:// ]]; then
                GITHUB_URL="\$1"
            else
                SCOPE_FILE_PATH="\$1"
            fi
            shift
            ;;
    esac
done

# If SCOPE_FILE is not provided and a default scope file exists, use it
if [[ -z "\$SCOPE_FILE_PATH" ]] && [[ -f "\${BASE_DIR}/\${SCOPE_FILE_DEFAULT}" ]]; then
    SCOPE_FILE_PATH="\${BASE_DIR}/\${SCOPE_FILE_DEFAULT}"
fi

# Change to the script directory and run yarn analyze
pushd \$SCRIPT_DIR > /dev/null
yarn analyze "\$BASE_PATH" "\$SCOPE_FILE_PATH" "\$GITHUB_URL"
popd > /dev/null

# Move report to the current directory
mv "\$SCRIPT_DIR/report.md" "\$BASE_DIR/analyzer_report.md"

# Check for report and open it if desired
REPORT_PATH="\${BASE_DIR}/analyzer_report.md"
if [[ -f \$REPORT_PATH && -n \$EDITOR_FLAG ]]; then
    case "\$EDITOR_FLAG" in
        "-vim")
            vim \$REPORT_PATH
            ;;
        "-nano")
            nano \$REPORT_PATH
            ;;
        "code")
            code \$REPORT_PATH
            ;;
    esac
fi
EOL

# Step 3: Create a symbolic link in ~/.local/bin
echo "Creating symbolic link in ~/.local/bin for global access..."
ln -s "${SCRIPT_PATH}" ~/.local/bin/analyze4

echo "Installation complete! You can now use analyze4 command anywhere in your system."
