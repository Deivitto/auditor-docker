#!/bin/bash

# Install LaTeX packages
echo "Installing LaTeX packages..."
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-lang-english

# Clean up apt cache to save space
echo "Cleaning up..."
apt-get clean
rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository
echo "Cloning spearbit-audits/report-generator-template..."
git clone https://github.com/spearbit-audits/report-generator-template.git
