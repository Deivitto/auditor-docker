#!/bin/bash

TEMPLATES_DIR="templates"
ISSUES_DIR="${TEMPLATES_DIR}/issues"
TEMPLATE_NAMES=("Code4renaHM" "Codehawks" "Sherlock" "Spearbit")
ACRONYMS=("c4" "ch" "sh" "sp")

display_help() {
    echo "Usage: issue [1-4 or acronym] [-n custom_name] [-nano|-vim]"
    echo "       issue -h"
    echo ""
    echo "Options:"
    echo "  1, c4   - Code4renaHM"
    echo "  2, ch   - Codehawks"
    echo "  3, sh   - Sherlock"
    echo "  4, sp   - Spearbit"
    echo "  -n      - Specify a custom name for the issue file."
    echo "  -nano   - Open the issue file in nano."
    echo "  -vim    - Open the issue file in vim."
    echo "  -h      - Display this help message."
}

parse_template_name() {
    local arg="$1"
    case "$arg" in
        "1"|"c4") echo "Code4renaHM" ;;
        "2"|"ch") echo "Codehawks" ;;
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

main() {
    if [[ "$#" -eq 0 ]]; then
        display_help
        exit 1
    fi

    local editor="code"
    local custom_name=""
    local template_name=""

    for arg in "$@"; do
        case "$arg" in
            "-h") display_help; exit 0 ;;
            "-nano") editor="nano" ;;
            "-vim") editor="vim" ;;
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
