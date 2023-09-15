#!/bin/bash

# Constants
REPO_URL="https://github.com/Deivitto/auditor-docker.git"
TEMP_DIR=$(mktemp -d)
LOCAL_DIR="$HOME"


# Clone the repo to the temporary directory
git clone "$REPO_URL" "$TEMP_DIR"

# Function to check differences between local and remote folders
check_differences() {
    local folder_name="$1"
    local files_to_update=()
    
    for file in "$TEMP_DIR/$folder_name/"*; do
        fname=$(basename "$file")
        if [[ -f "$LOCAL_DIR/$folder_name/$fname" ]]; then
            diff_output=$(diff "$file" "$LOCAL_DIR/$folder_name/$fname")
            if [[ ! -z "$diff_output" ]]; then
                files_to_update+=("$fname")
            fi
        else
            echo "New file $fname detected in $folder_name, will be copied..."
            files_to_update+=("$fname")
        fi
    done

    if [[ ${#files_to_update[@]} -ne 0 ]]; then
        echo "Differences detected in $folder_name in the following files:"
        for fname in "${files_to_update[@]}"; do
            echo "- $fname"
        done

        # Get user input
        while true; do
            read -p "Do you want to update the files in $folder_name? (y/n) " choice
            case $choice in
                [Yy]* ) 
                    for fname in "${files_to_update[@]}"; do
                        echo "Updating $fname in $folder_name..."
                        cp "$TEMP_DIR/$folder_name/$fname" "$LOCAL_DIR/$folder_name/$fname"
                        # Apply execute permissions if it's a script
                        if [[ "$folder_name" == "scripts" && "$fname" == *.sh ]]; then
                            chmod +x "$LOCAL_DIR/$folder_name/$fname"
                        fi
                    done
                    break
                    ;;
                [Nn]* )
                    echo "Update for $folder_name cancelled."
                    return 1
                    ;;
                * )
                    echo "Please answer with y or n."
                    ;;
            esac
        done
    else
        echo "No differences detected in $folder_name. It's up to date!"
    fi
}

# Check differences for scripts and templates
check_differences "scripts"
check_differences "templates"

# Clean up
rm -rf "$TEMP_DIR"

echo "Update process completed."
