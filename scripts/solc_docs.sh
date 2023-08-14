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
  echo "Command $pdf_viewer not found."
  read -p "Do you want to install it? [y/N] " choice
  if [[ $choice == "y" || $choice == "Y" ]]; then
    if [[ $pdf_viewer == "xdg-open" ]]; then
      apt-get update && apt-get install -y xdg-utils
    elif [[ $pdf_viewer == "evince" ]]; then
      apt-get update && apt-get install -y evince
    fi
  else
    exit 1
  fi
fi

$pdf_viewer /home/whitehat/scripts/solidity_docs/${book_name}.pdf
