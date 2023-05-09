#!/bin/bash
    
    echo "Installing brew and echidna..."
    
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/whitehat/.bashrc  && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew install --HEAD echidna && \
    brew postinstall echidna
    
    echo "Installation completed!"
