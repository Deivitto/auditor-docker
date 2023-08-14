#!/bin/bash

## This code is just a selector for when launching add2 or add2lbox
## This code launches the other scripts in this folder
## Scripts available:
## 1 - Echidna
## 2 - Certora Prover
## 3 - Mythril
## 4 - Manticore + Etheno 
## 5 - Noir (Nargo)
## 6 - Circom 
## 7 - Vyper, Brownie, py-solc-select and other Python related tools for Ethereum
## 8 - If launched within VSCode, it will install common VSCode extensions for audits
## 9 - Medusa Fuzzer
##

DIALOG_CANCEL=1
DIALOG_ESC=255

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
    --menu "Please select an option:" 0 0 9 \
    "1" "Install Echidna" \
    "2" "Install Certora Prover + Java SDK 11 (requirement)" \
    "3" "Install Mythril" \
    "4" "Install Manticore + Etheno" \
    "5" "Install Noir (Nargo)" \
    "6" "Install Circom" \
    "7" "Install Python Developer Tools" \
    "8" "Install VS Code Audit Extensions" \
    "9" "Install Medusa Fuzzer" \
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
        run_with_progress "/home/whitehat/scripts/echidna_installer.sh" "Echidna"
        result="echidna_installer.sh installed successfully!"
        display_result "Result"
    ;;
    2)
        run_with_progress "/home/whitehat/scripts/certora_setup.sh" "Certora Prover + Java SDK 11"
        result="certora_setup.sh installed successfully!"
        display_result "Result"
    ;;
    3)
        run_with_progress "/home/whitehat/scripts/mythril_install.sh" "Mythril"
        result="mythril_install.sh installed successfully!"
        display_result "Result"
    ;;
    4)
        run_with_progress "/home/whitehat/scripts/advanced_tob_tools_setup.sh" "Manticore + Etheno"
        result="advanced_tob_tools_setup.sh installed successfully!"
        display_result "Result"
    ;;
    5)
        run_with_progress "/home/whitehat/scripts/noir_setup.sh" "Noir (Nargo)"
        result="noir_setup.sh installed successfully!"
        display_result "Result"
    ;;
    6)
        run_with_progress "/home/whitehat/scripts/circom_setup.sh" "Circom"
        result="circom_setup.sh installed successfully!"
        display_result "Result"
    ;;
    7)
        run_with_progress "/home/whitehat/scripts/py_developer_setup.sh" "Python Developer Tools"
        result="py_developer_setup.sh installed successfully!"
        display_result "Result"
    ;;
    8)
        run_with_progress "/home/whitehat/scripts/vscode_audit_extensions.sh" "VS Code Audit Extensions"
        result="vscode_audit_extensions.sh installed successfully!"
        display_result "Result"
    ;;
    9)
        run_with_progress "/home/whitehat/scripts/medusa_fuzzer.sh" "Medusa Fuzzer"
        result="medusa_fuzzer.sh installed successfully!"
        display_result "Result"
    ;;
esac

done
