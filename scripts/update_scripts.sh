#!/bin/bash

## Script to update all the script folder, 
## adding new ones if they exist
## and updating the previous ones if desired

# Constants
REPO_URL="https://github.com/Deivitto/auditor-docker.git"
TEMP_DIR=$(mktemp -d)
LOCAL_SCRIPTS_DIR="$(dirname "$0")"  # We are assuming this script is in the scripts directory

# Clone the repo to the temporary directory
git clone "$REPO_URL" "$TEMP_DIR"

# Check for differences
files_to_update=()

for file in "$TEMP_DIR/scripts/"*; do
    fname=$(basename "$file")
    if [[ -f "$LOCAL_SCRIPTS_DIR/$fname" ]]; then
        diff_output=$(diff "$file" "$LOCAL_SCRIPTS_DIR/$fname")
        if [[ ! -z "$diff_output" ]]; then
            files_to_update+=("$fname")
        fi
    else
        echo "New file $fname detected, will be copied..."
        files_to_update+=("$fname")
    fi
done

# If there are differences, display them and ask for confirmation
if [[ ${#files_to_update[@]} -ne 0 ]]; then
    echo "Differences detected in the following files:"
    for fname in "${files_to_update[@]}"; do
        echo "- $fname"
    done
    
    # Get user input
    while true; do
        read -p "Do you want to update the files? (y/n) " choice
        case $choice in
            [Yy]* ) 
                for fname in "${files_to_update[@]}"; do
                    echo "Updating $fname..."
                    cp "$TEMP_DIR/scripts/$fname" "$LOCAL_SCRIPTS_DIR/$fname"
                done
                break
                ;;
            [Nn]* )
                echo "Update cancelled."
                exit 1
                ;;
            * )
                echo "Please answer with y or n."
                ;;
        esac
    done
else
    echo "No differences detected. Your scripts are up to date!"
fi

# Clean up
rm -rf "$TEMP_DIR"

echo "Update process completed."
