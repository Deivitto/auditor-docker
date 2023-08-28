#!/bin/bash

TEMPLATES_DIR="templates"
ISSUES_DIR="${TEMPLATES_DIR}/issues"
TEMPLATE_NAMES=("Code4renaHM" "CodeHawks" "Sherlock" "Spearbit")
ACRONYMS=("c4" "ch" "sh" "sp")

display_help() {
    echo "Usage: issue [1-4 or acronym] [-n custom_name] [-nano|-vim|-code|-d]"
    echo "       issue -h"
    echo ""
    echo "Options:"
    echo "  1, c4   - Code4renaHM"
    echo "  2, ch   - CodeHawks"
    echo "  3, sh   - Sherlock"
    echo "  4, sp   - Spearbit"
    echo "  -n      - Specify a custom name for the issue file."
    echo "  -nano   - Open the issue file in nano."
    echo "  -vim    - Open the issue file in vim."
    echo "  -code   - Open the issue file in code. This is the default option."
    echo "  -d      - Don't display the file in any editor."
    echo "  -h      - Display this help message."
}

parse_template_name() {
    local arg="$1"
    case "$arg" in
        "1"|"c4") echo "Code4renaHM" ;;
        "2"|"ch") echo "CodeHawks" ;;
        "3"|"sh") echo "Sherlock" ;;
        "4"|"sp") echo "Spearbit" ;;
        *) echo ""; exit 1 ;;
    esac
}

generate_issue_filename() {
    local template="$1"
    local custom_name="$2"

    if [[ -z "$custom_name" ]]; then
        echo "${template}$(date +'%Y%m%d%H%M')"
    else
        echo "${custom_name}"
    fi
}

resolve_collision() {
    local base_name="$1"
    local count=1

    while [[ -f "${ISSUES_DIR}/${base_name}-${count}" ]]; do
        ((count++))
    done

    echo "${base_name}-${count}"
}

check_code_command_exists() {
    if command -v code &> /dev/null; then
        return 0
    else
        return 1
    fi
}

main() {
    if [[ "$#" -eq 0 ]]; then
        display_help
        exit 1
    fi

    local editor="code"
    local custom_name=""
    local template_name=""

    local use_code_explicitly=false
    local disable_editor=false

    for arg in "$@"; do
        case "$arg" in
            "-h") display_help; exit 0 ;;
            "-nano") editor="nano" ;;
            "-vim") editor="vim" ;;
            "-d") disable_editor=true ;;
            "-code") use_code_explicitly=true ;;
            "-n") custom_name_next=true ;;
            *)
                if [[ "$custom_name_next" == true ]]; then
                    custom_name="$arg"
                    custom_name_next=false
                else
                    template_name=$(parse_template_name "$arg")
                fi
            ;;
        esac
    done

    # Determine the default editor based on the presence of 'code' command, and the provided options.
    if ! disable_editor && [[ "$editor" == "code" ]]; then
        if ! check_code_command_exists && ! $use_code_explicitly; then
            echo "'code' command not found. Defaulting to 'nano' as the editor."
            editor="nano"
        fi
    fi

    # Display help
    if [[ -z "$template_name" ]]; then
        display_help
        exit 1
    fi

    [[ ! -d "$ISSUES_DIR" ]] && mkdir -p "$ISSUES_DIR"

    local issue_filename=$(generate_issue_filename "$template_name" "$custom_name")
    local issue_path="${ISSUES_DIR}/${issue_filename}"

    if [[ -f "$issue_path" ]]; then
        issue_filename=$(resolve_collision "$issue_filename")
        issue_path="${ISSUES_DIR}/${issue_filename}"
    fi

    cp "${TEMPLATES_DIR}/${template_name}" "$issue_path"
    $editor "$issue_path"
}

main "$@"
