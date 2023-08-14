#!/bin/bash
    cd /home/whitehat
    
    python3.9 -m venv .mythril_env
    
    source .mythril_env/bin/activate
    
    pip install mythril
    
    deactivate
    
echo -e 'function myth() {\n
    source $(pwd)/.mythril_env/bin/activate\n
    command myth "$@"\n
    deactivate\n
}' >> ~/.bashrc

    source ~/.bashrc
    
    echo "Mythril installation complete. Use the 'myth' command to run Mythril within the virtual environment."
    
