#!/bin/bash
    cd /home/whitehat
    
    python3.9 -m venv mythril_env
    
    source mythril_env/bin/activate
    
    pip install mythril
    
    deactivate
    
    echo "alias myth='source $(pwd)/mythril_env/bin/activate && myth \$@ && deactivate'" >> ~/.bashrc
    
    source ~/.bashrc
    
    echo "Mythril installation complete. Use the 'myth' command to run Mythril within the virtual environment."
    
