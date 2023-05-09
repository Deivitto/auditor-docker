#!/bin/bash
    
    echo "Installing brew and echidna..."
    
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
    sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/whitehat/.bashrc  && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    sudo brew install --HEAD echidna && \
    sudo brew postinstall echidna
    
    echo "Installation completed!"
