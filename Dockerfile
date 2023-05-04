# syntax=docker/dockerfile:1.3
FROM ubuntu:jammy AS audit-toolbox

LABEL org.opencontainers.image.authors="Deivitto"
LABEL org.opencontainers.image.description="Audit Toolbox for Ethereum Smart Contracts"

# Update package list and install necessary programs
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    vim \
    nano \
    yarn \
    npm \
    z3 \
    libz3-dev \
    ripgrep \
    gawk \
    libssl-dev \
    sudo \
    wget \
    software-properties-common \
    libudev-dev \
    locales \
    gpg-agent \
    dialog \
    procps \
    file \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Ethereum and Yices PPA repositories and install packages
RUN add-apt-repository -y ppa:ethereum/ethereum && \
    add-apt-repository -y ppa:sri-csl/formal-methods && \
    add-apt-repository -y ppa:deadsnakes/ppa  && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ethereum \
    python3.9 \
    python3.9-dev \
    python3.9-venv \
    python3-pip \
    python3.9-distutils \
    yices2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install global npm packages
RUN npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \
    ganache \
    truffle


# Install pnpm
RUN npm install --omit=dev --global --force \
    pnpm

# Install Julia
RUN curl -fsSL https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.1-linux-x86_64.tar.gz -o julia.tar.gz && \
    mkdir -p /opt/julia && \
    tar -xzf julia.tar.gz -C /opt/julia --strip-components 1 && \
    rm julia.tar.gz && \
    ln -s /opt/julia/bin/julia /usr/local/bin/julia

# Set up the user environment
RUN useradd -m -G sudo whitehat && \
    echo 'whitehat ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    echo 'whitehat:ngmi' | chpasswd && \
    usermod --shell /bin/bash whitehat

# Create the scripts directory
RUN mkdir -p /home/whitehat/scripts && \
# Set the owner and group of the scripts directory to whitehat
chown -R whitehat:whitehat /home/whitehat/scripts && \
# Set the permissions of the scripts directory to allow only the owner to read, write, and execute
chmod -R 700 /home/whitehat/scripts

# Create the 'add2' and 'add2lbox' scripts
RUN echo -e '#!/bin/bash\n/home/whitehat/scripts/installer.sh' > /home/whitehat/add2 && \
    echo -e '#!/bin/bash\n/home/whitehat/scripts/installer.sh' > /home/whitehat/add2lbox

# Make the scripts executable
RUN chmod +x /home/whitehat/add2 /home/whitehat/add2lbox


# Create noir_setup.sh script in /home/whitehat/scripts
RUN echo 'source ~/.cargo/env && \
    mkdir -p $HOME/.nargo/bin && \
    curl -o $HOME/.nargo/bin/nargo-x86_64-unknown-linux-gnu.tar.gz -L https://github.com/noir-lang/noir/releases/download/v0.4.1/nargo-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xvf $HOME/.nargo/bin/nargo-x86_64-unknown-linux-gnu.tar.gz -C $HOME/.nargo/bin/ && \
    echo -e "\\nexport PATH=$PATH:$HOME/.nargo/bin" >> ~/.bashrc && \
    source ~/.bashrc' > /home/whitehat/scripts/noir_setup.sh && \
    chmod +x /home/whitehat/scripts/noir_setup.sh

# Install Foundry, Forge, Cast, Anvil, Chisel, and Vim Solidity plugins using cargo_foundry_installer script
RUN echo 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    curl -L https://foundry.paradigm.xyz | bash && \
    source ~/.bashrc && \
    export PATH="~/.foundry/bin:${PATH}" && \
    foundryup' > /home/whitehat/scripts/cargo_foundry_installer.sh && \
    chmod +x /home/whitehat/scripts/cargo_foundry_installer.sh

# Create circom_setup.sh script in /home/whitehat/scripts
RUN echo 'npm install --omit=dev --global --force circom' > /home/whitehat/scripts/circom_setup.sh && \
    chmod +x /home/whitehat/scripts/circom_setup.sh

# Create py_developer_setup.sh script in /home/whitehat/scripts
RUN echo 'python3.9 -m pip install \
    pyevmasm \
    py-solc-x \
    vyper \
    brownie' > /home/whitehat/scripts/py_developer_setup.sh && \
    chmod +x /home/whitehat/scripts/py_developer_setup.sh

# Create Foundry, Forge, Cast, Anvil, Chisel script
RUN echo '#!/bin/bash\n\
    \n\
    echo "Installing brew and echidna..."\n\
    \n\
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \\\n\
    (echo; echo '\''eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'\'') >> /home/linuxbrew/.bashrc  && \\\n\
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \\\n\
    brew install --HEAD echidna\n\
    \n\
    echo "Installation completed!"' > /home/whitehat/scripts/echidna_installer.sh && \
    chmod +x /home/whitehat/scripts/echidna_installer.sh


# Create certora_setup.sh script in /home/whitehat/scripts
RUN echo 'sudo apt-get update && \
    sudo apt-get install -y openjdk-11-jdk && \
    java -version && \
    python3.9 -m pip install certora-cli && \
    export CERTORAKEY=$1 && \
    cd ~ && \
    echo "PATH=\$PATH:/full/path/to/solc/executable/folder" >> ~/.profile && \
    source ~/.profile' > /home/whitehat/scripts/certora_setup.sh && \
    chmod +x /home/whitehat/scripts/certora_setup.sh

# Create advanced_tob_tools_setup.sh script in /home/whitehat/scripts
RUN echo 'python3.9 -m pip install \
    manticore \
    etheno \
    "crytic-compile>=0.3.1,<0.4.0" \
    "web3>=6.0.0"' > /home/whitehat/scripts/advanced_tob_tools_setup.sh && \
    chmod +x /home/whitehat/scripts/advanced_tob_tools_setup.sh

# Change user and set preferences
USER whitehat
ENV HOME="/home/whitehat"
ENV SCRIPTS="/home/whitehat/scripts"
ENV PATH="${PATH}:${HOME}/.local/bin"
WORKDIR /home/whitehat

# Install Python packages and clean up cache
RUN python3.9 -m pip install --no-cache-dir pip setuptools wheel

# Install tools
RUN python3.9 -m pip install --no-cache-dir \
    solc-select \
    slither-analyzer \
    # echidna \
    halmos 
# mythril fails fore some reason

#Vim Solidity plugins
RUN git clone https://github.com/tomlion/vim-solidity.git ~/.vim/pack/plugins/start/vim-solidity 

# Install all versions of solc and set the latest as default
RUN solc-select install all && \
    SOLC_VERSION=0.8.0 solc-select versions | head -n1 | xargs solc-select use

RUN echo '# Auditor Toolbox Scripts\n\
    \n\
    ## Usage\n\
    \n\
    ### installer.sh\n\
    Interactive script to install other toolbox scripts. Use the following command to run it:\n\
    \n\
    ```bash\n\
    add2lbox\n\
    ```\n\
    or\n\
    ```bash\n\
    ./scripts/installer.sh\n\
    ```\n\
    \n\
    ### py_developer_setup.sh\n\
    Installs the following Python packages:\n\
    - pyevmasm\n\
    - py-solc-x\n\
    - vyper\n\
    - brownie\n\
    \n\
    To run the script, use the following command:\n\
    \n\
    ```bash\n\
    ./scripts/py_developer_setup.sh\n\
    ```\n\
    \n\
    ### certora_setup.sh\n\
    Installs OpenJDK 11, Certora CLI, and sets the Certora key and solc path.\n\
    \n\
    To run the script, use the following command:\n\
    \n\
    ```bash\n\
    ./scripts/certora_setup.sh <premium_key>\n\
    ```\n\
    Replace `<premium_key>` with your actual Certora premium key.\n\
    \n\
    ### advanced_tob_tools_setup.sh\n\
    Installs the following Trail of Bits tools:\n\
    - manticore\n\
    - etheno\n\
    \n\
    To run the script, use the following command:\n\
    \n\
    ```bash\n\
    ./scripts/advanced_tob_tools_setup.sh\n\
    ```\n\
    \n\
    ### noir_setup.sh\n\
    Installs Noir language (Nargo).\n\
    \n\
    To run the script, use the following command:\n\
    \n\
    ```bash\n\
    ./scripts/noir_setup.sh\n\
    ```\n\
    \n\
    ### circom_setup.sh\n\
    Installs Circom.\n\
    \n\
    To run the script, use the following command:\n\
    \n\
    ```bash\n\
    ./scripts/circom_setup.sh\n\
    ```\n\
    \n\
    ### echidna_installer.sh\n\
    Installs Homebrew and Echidna.\n\
    \n\
    To run the script, use the following command:\n\
    \n\
    ```bash\n\
    ./scripts/echidna_installer.sh\n\
    ```\n\
    ' > /home/whitehat/scripts/readme.md


RUN echo '#!/bin/bash\n\
    \n\
    DIALOG_CANCEL=1\n\
    DIALOG_ESC=255\n\
    \n\
    display_result() {\n\
    dialog --title "$1" \\\n\
    --no-collapse \\\n\
    --msgbox "$result" 0 0\n\
    }\n\
    \n\
    while true; do\n\
    exec 3>&1\n\
    selection=$(dialog \\\n\
    --backtitle "Auditor Toolbox Installer" \\\n\
    --title "Menu" \\\n\
    --clear \\\n\
    --cancel-label "Exit" \\\n\
    --menu "Please select an option:" 0 0 6 \\\n\
    "1" "Install Python Developer Tools" \\\n\
    "2" "Install Certora Prover + Java SDK 11 (requirement)" \\\n\
    "3" "Install Manticore + Etheno" \\\n\
    "4" "Install Noir (Nargo) (Needs Cargo (6))" \\\n\
    "5" "Install Circom" \\\n\
    "6" "Install Cargo + Foundry" \\\n\
    "7" "Install Echidna" \\\n\
    2>&1 1>&3)\n\
    exit_code=$?\n\
    exec 3>&-\n\
    case $exit_code in\n\
    $DIALOG_CANCEL)\n\
    clear\n\
    echo "Installation canceled."\n\
    exit\n\
    ;;\n\
    $DIALOG_ESC)\n\
    clear\n\
    echo "Installation canceled."\n\
    exit\n\
    ;;\n\
    esac\n\
    case $selection in\n\
    0)\n\
    clear\n\
    echo "Installation canceled."\n\
    exit\n\
    ;;\n\
    1)\n\
    ./py_developer_setup.sh\n\
    result="py_developer_setup.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    2)\n\
    ./certora_setup.sh\n\
    result="certora_setup.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    3)\n\
    ./advanced_tob_tools_setup.sh\n\
    result="advanced_tob_tools_setup.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    4)\n\
    ./noir_setup.sh\n\
    result="noir_setup.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    5)\n\
    ./circom_setup.sh\n\
    result="circom_setup.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    6)\n\
    ./cargo_foundry_installer.sh\n\
    result="cargo_foundry_installer.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    7)\n\
    ./echidna_installer.sh\n\
    result="echidna_installer.sh installed successfully!"\n\
    display_result "Result"\n\
    ;;\n\
    esac\n\
    done' > /home/whitehat/scripts/installer.sh && \
    chmod +x /home/whitehat/scripts/installer.sh


# Move the scripts to a directory in the PATH
RUN mv /home/whitehat/add2 /home/whitehat/add2lbox /home/whitehat/.local/bin/

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# motd
# Create the ASCII design for the Auditor Toolbox
USER root
RUN echo -e '\\nAUDITOR TOOLBOX\\n\\nhttps://github.com/misirov/auditor-docker/\\n\\nby\\n#       _             _ _ _                       \\n#      / \\  _   _  __| (_) |_ ___  _ __           \\n#     / _ \\| | | |/ _\` | | __/ _ \\| '\''__|          \\n#    / ___ \\ |_| | (_| | | || (_) | |             \\n#   /_/   \\_\\__,_|\\__,_|_|\\__\\___/|_|             \\n#              _____           _ _                \\n#             |_   _|__   ___ | | |__   _____  __ \\n#          _____| |/ _ \\ / _ \\| | '\''_ \\ / _ \\ \\/ / \\n#         |_____| | (_) | (_) | | |_) | (_) >  <  \\n#               |_|\\___/ \\___/|_|_.__/ \\\\___/_/\\_\\ \\n#                                                \\n\\nAuditor 2lbox\\nCreated by GitHub Deivitto\\nCollaborators: misirov, luksgrin\\n\\nSecurity Tools and Resources Installed:\\n\\n[PlaceholderLinks]\\n\\nUse \\`solc-select\\` to switch between different versions of \\`solc\\`\\nUse add2 or add2lbox to quick install auditor packages\\n' >> /etc/motd
RUN echo -e '\ncat /etc/motd\n' >> /etc/bash.bashrc
USER whitehat

# CMD ["/bin/bash"] is used to set the default command for the container to start a new Bash shell.
# This ensures that when the container is run, the user will be dropped into an interactive Bash shell by default.
ENTRYPOINT ["/bin/bash"]



# This Dockerfile includes the separation of the packages and their installation into separate scripts, 
# as well as the creation of the `readme.md` file in the `scripts` folder with instructions on how to use the scripts.

