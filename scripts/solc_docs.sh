#!/bin/bash

# Gets the latest solc docs pdf and if a pdf reader is installed, it opens the file

pdf_viewer="code"
book_name="solidity_docs"

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --book)
      shift
      ;;
    --pdf-xdg)
      pdf_viewer="xdg-open"
      shift
      ;;
    --pdf-evince)
      pdf_viewer="evince"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

mkdir -p /home/whitehat/scripts/solidity_docs

if [[ ! -f /home/whitehat/scripts/solidity_docs/${book_name}.pdf ]]; then
  wget -O /home/whitehat/scripts/solidity_docs/${book_name}.pdf https://docs.soliditylang.org/_/downloads/en/latest/pdf/
fi

if ! command -v $pdf_viewer &> /dev/null; then
  if [[ $pdf_viewer == "code" ]]; then
    echo "'code' viewer not found."
    read -p "Which viewer would you like to use (1 for xdg-open, 2 for evince, anything else to exit): " choice
    case $choice in
      1)
        pdf_viewer="xdg-open"
        if ! command -v $pdf_viewer &> /dev/null; then
          read -p "Do you want to install xdg-open? [y/N] " install_choice
          if [[ $install_choice == "y" || $install_choice == "Y" ]]; then
            apt-get update && apt-get install -y xdg-utils
          else
            exit 1
          fi
        fi
        ;;
      2)
        pdf_viewer="evince"
        if ! command -v $pdf_viewer &> /dev/null; then
          read -p "Do you want to install evince? [y/N] " install_choice
          if [[ $install_choice == "y" || $install_choice == "Y" ]]; then
            apt-get update && apt-get install -y evince
          else
            exit 1
          fi
        fi
        ;;
      *)
        exit 1
        ;;
    esac
  else
    echo "Command $pdf_viewer not found."
    exit 1
  fi
fi

$pdf_viewer /home/whitehat/scripts/solidity_docs/${book_name}.pdf
