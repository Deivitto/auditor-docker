#!/bin/bash

## This code is just a selector called by `add2` or `add2lbox`
## This code launches the other scripts in this folder
## Scripts available:
# "1" "Install Certora Prover + Java SDK 11 (requirement)" \
# "2" "Install Echidna" \
# "3" "Install Mythril" \
# "4" "Install Manticore" \
# "5" "Install Medusa Fuzzer" \
# "6" "Install 4nalyz3r" \
# "7" "Install Pyrometer" \
# "8" "Install Brownie" \
# "9" "Install Etheno" \
# "10" "Install Noir (Nargo)" \
# "11" "Install Circom" \
# "12" "Install Embark" \
# "13" "Install Python Developer Tools" \
# "14" "Install VS Code Audit Extensions" \
# "15" "Check installed versions" \

##

DIALOG_CANCEL=1
DIALOG_ESC=255

display_help() {
    echo "Usage: $0 [-h]"
    echo
    echo "Options:"
    echo "  -h   Show this help message and exit."
    echo
    echo "Available installations:"
    echo "  1  Install Certora Prover + Java SDK 11 (requirement)"
    echo "  2  Install Echidna"
    echo "  3  Install Mythril"
    echo "  4  Install Manticore"
    echo "  5  Install Medusa Fuzzer"
    echo "  6  Install 4nalyz3r"
    echo "  7  Install Pyrometer"
    echo "  8  Install Brownie"
    echo "  9  Install Etheno"
    echo "  10 Install Noir (Nargo)"
    echo "  11 Install Circom"
    echo "  12 Install Embark"
    echo "  13 Install Python Developer Tools"
    echo "  14 Install VS Code Audit Extensions"
    echo "  15 Check installed versions"
    exit 0
}

while getopts "h" opt; do
    case $opt in
        h)
            display_help
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done


display_result() {
    dialog --title "$1" \
    --no-collapse \
    --msgbox "$result" 0 0
}

run_with_progress() {
    local script="$1"
    local title="$2"

    local temp_output=$(mktemp)

    $script > $temp_output 2>&1 &

    local pid=$!

    {
        while kill -0 $pid 2>/dev/null; do
            cat $temp_output
            sleep 1
        done
        wait $pid
    } | dialog --title "Installing $title, please wait..." --progressbox 20 80

    rm -f $temp_output
}

while true; do
    exec 3>&1
    selection=$(dialog \
        --backtitle "Auditor Toolbox Installer" \
        --title "Menu" \
        --clear \
        --cancel-label "Exit" \
        --menu "Please select an option:" 0 0 16 \
        "1" "Install Certora Prover + Java SDK 11 (requirement)" \
        "2" "Install Echidna" \
        "3" "Install Mythril" \
        "4" "Install Manticore" \
        "5" "Install Medusa Fuzzer" \
        "6" "Install 4nalyz3r" \
        "7" "Install Pyrometer" \
        "8" "Install Brownie" \
        "9" "Install Etheno" \
        "10" "Install Noir (Nargo)" \
        "11" "Install Circom" \
        "12" "Install Embark" \
        "13" "Install Python Developer Tools" \
        "14" "Install VS Code Audit Extensions" \
        "15" "Check installed versions" \
        2>&1 1>&3)
    exit_code=$?
    exec 3>&-
    case $exit_code in
        $DIALOG_CANCEL)
            clear
            echo "Installation canceled."
            exit
        ;;
        $DIALOG_ESC)
            clear
            echo "Installation canceled."
            exit
        ;;
    esac
    case $selection in
        0)
            clear
            echo "Installation canceled."
            exit
        ;;
        1)
            run_with_progress "/home/whitehat/scripts/certora_setup.sh" "Certora Prover + Java SDK 11"
            result="certora_setup.sh installed successfully!"
            display_result "Result"
        ;;
        2)
            run_with_progress "/home/whitehat/scripts/echidna_installer.sh" "Echidna"
            result="echidna_installer.sh installed successfully!"
            display_result "Result"
        ;;
        3)
            run_with_progress "/home/whitehat/scripts/mythril_install.sh" "Mythril"
            result="mythril_install.sh installed successfully!"
            display_result "Result"
        ;;
        4)
            run_with_progress "/home/whitehat/scripts/manticore.sh" "Manticore"
            result="manticore.sh installed successfully!"
            display_result "Result"
        ;;
        5)
            run_with_progress "/home/whitehat/scripts/medusa_fuzzer.sh" "Medusa Fuzzer"
            result="medusa_fuzzer.sh installed successfully!"
            display_result "Result"
        ;;
        6)
            run_with_progress "/home/whitehat/scripts/analyzer_installer.sh" "4nalyz3r"
            result="analyzer_installer.sh installed successfully!"
            display_result "Result"
        ;;
        7)
            run_with_progress "/home/whitehat/scripts/pyrometer_installer.sh" "Pyrometer"
            result="pyrometer_installer.sh installed successfully!"
            display_result "Result"
        ;;
        8)
            run_with_progress "/home/whitehat/scripts/brownie.sh" "Brownie"
            result="brownie.sh installed successfully!"
            display_result "Result"
        ;;
        9)
            run_with_progress "/home/whitehat/scripts/etheno.sh" "Etheno"
            result="etheno.sh installed successfully!"
            display_result "Result"
        ;;
        10)
            run_with_progress "/home/whitehat/scripts/noir_setup.sh" "Noir (Nargo)"
            result="noir_setup.sh installed successfully!"
            display_result "Result"
        ;;
        11)
            run_with_progress "/home/whitehat/scripts/circom_setup.sh" "Circom"
            result="circom_setup.sh installed successfully!"
            display_result "Result"
        ;;
        12)
            run_with_progress "/home/whitehat/scripts/embark.sh" "Embark"
            result="embark.sh installed successfully!"
            display_result "Result"
        ;;
        13)
            run_with_progress "/home/whitehat/scripts/py_developer_setup.sh" "Python Developer Tools"
            result="py_developer_setup.sh installed successfully!"
            display_result "Result"
        ;;
        14)
            run_with_progress "/home/whitehat/scripts/vscode_audit_extensions.sh" "VS Code Audit Extensions"
            result="vscode_audit_extensions.sh installed successfully!"
            display_result "Result"
        ;;
        15)
            run_with_progress "/home/whitehat/scripts/versions.sh" "Checking installed versions"
            result="versions.sh executed successfully!"
            display_result "Result"
        ;;
    esac
done