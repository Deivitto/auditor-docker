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
    openssh-client \
    pandoc \
    texlive \
    ca-certificates && \
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
    rm -rf /var/lib/apt/lists/*

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

# Change user and set preferences
USER whitehat
ENV HOME="/home/whitehat"
ENV SCRIPTS="/home/whitehat/scripts"
ENV PATH="${PATH}:${HOME}/.local/bin"
WORKDIR /home/whitehat

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 
ENV NVM_DIR="/home/whitehat/.nvm"

# Install Node, get Node version, update PATH and install global npm packages
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install --lts && \
    nvm alias default lts/* && \
    nvm use default && \
    node_version=$(node --version) && \
    echo "PATH=\"/home/whitehat/.nvm/versions/node/$node_version/bin:${PATH}\"" >> /home/whitehat/.bashrc && \
    . /home/whitehat/.bashrc && \
    npm install --omit=dev --global --force ganache truffle pnpm && \
    # Install Yarn
    . "$NVM_DIR/nvm.sh" && \
    curl -o- -L https://yarnpkg.com/install.sh | bash && \
    # Update PATH for Yarn global binaries
    echo "export PATH=\"$(yarn global bin):$PATH\"" >> /home/whitehat/.bashrc

# Create the scripts directory
RUN mkdir -p /home/whitehat/scripts

# Create the 'add2' and 'add2lbox' scripts
RUN echo '#!/bin/bash\n/home/whitehat/scripts/installer.sh' > /home/whitehat/add2lbox 

# Make the scripts executable
RUN chmod +x /home/whitehat/add2lbox


# Install Python packages and clean up cache
RUN python3.9 -m pip install --no-cache-dir pip setuptools wheel
# Install python tools
RUN python3.9 -m pip install --no-cache-dir \
    solc-select \
    slither-analyzer pandocfilters pygments PyGithub \ 
    halmos && \
    # Clone the slitherin repository and run the setup script
    git clone https://github.com/pessimistic-io/slitherin.git ~/.slitherin && \
    cd ~/.slitherin && \
    python3.9 setup.py develop --user

#Vim Solidity plugins + pessimistic io slitherin
RUN git clone https://github.com/tomlion/vim-solidity.git ~/.vim/pack/plugins/start/vim-solidity 

# Install some popular 0.8 versions
RUN solc-select install 0.8.4 0.8.7 0.8.19 0.8.18 0.8.17 0.8.16 0.8.20 0.8.14 0.8.13 0.8.12 0.8.0 && \
    solc-select use 0.8.20

# Move the scripts to a directory in the PATH
RUN mv /home/whitehat/add2lbox /home/whitehat/.local/bin/

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

USER root
# RUN chown -R whitehat:whitehat /home/whitehat/
# Move scripts inside the folder and give permissions
COPY /scripts/*.sh /home/whitehat/scripts/
COPY /scripts/readme.md /home/whitehat/scripts/readme.md
RUN chmod +x /home/whitehat/scripts/*.sh && \
    # Set the owner and group of the scripts directory to whitehat
    chown -R whitehat:whitehat /home/whitehat/scripts
# Create the ASCII design for the Auditor Toolbox
COPY motd /etc/motd
# RUN echo -e "\\nAUDITOR TOOLBOX\\n\\nhttps://github.com/misirov/auditor-docker/\\n\\nby\\n#       _             _ _ _                       \\n#      / \\  _   _  __| (_) |_ ___  _ __           \\n#     / _ \\| | | |/ _\` | | __/ _ \\| '\''__|          \\n#    / ___ \\ |_| | (_| | | || (_) | |             \\n#   /_/   \\_\\__,_|\\__,_|_|\\__\\___/|_|             \\n#              _____           _ _                \\n#             |_   _|__   ___ | | |__   _____  __ \\n#          _____| |/ _ \\ / _ \\| | '\''_ \\ / _ \\ \\/ / \\n#         |_____| | (_) | (_) | | |_) | (_) >  <  \\n#               |_|\\___/ \\___/|_|_.__/ \\\\___/_/\\_\\ \\n#                                                \\n\\nAuditor 2lbox\\nCreated by GitHub Deivitto\\nCollaborators: misirov, luksgrin\\n\\nSecurity Tools and Resources Installed:\\n\\n- Foundry: forge\\n- Foundry Update: foundryup\\n- Slither: slither\\n- Echidna: echidna\\n- Mythril: myth\\n- Halmos: halmos\\n- Certora Prover: certoraRun\\n- Set Certora Key: certoraKey key\\n- Manticore: manticore\\n- Solc-select: solc-select\\n- Open last solity lang doc: solc-docs --book\\n\\nUse add2 or add2lbox to quick install auditor packages\\n" >> /etc/motd
RUN echo -e '\ncat /etc/motd\n' >> /etc/bash.bashrc
USER whitehat

# Add aliases
RUN echo "alias python3.9-pip='python3.9 -m pip'" >> ~/.bashrc && \
    echo "alias python3='python3.9'" >> ~/.bashrc && \
    echo "alias pip3='pip3.9'" >> ~/.bashrc && \
    echo 'alias certoraKey="~/scripts/certora_key_setup.sh"' >> ~/.bashrc && \
    echo "alias solc-docs='bash ~/scripts/solc_docs.sh'" >> ~/.bashrc && \
    echo "alias add2='add2lbox'" >> ~/.bashrc && \
    source ~/.bashrc

# ENTRYPOINT ["/bin/bash"] is used to set the default command for the container to start a new Bash shell.
# This ensures that when the container is run, the user will be dropped into an interactive Bash shell by default.
ENTRYPOINT ["/bin/bash"]

# This Dockerfile includes the separation of the packages and their installation into separate scripts, 
# as well as the creation of the `readme.md` file in the `scripts` folder with instructions on how to use the scripts.
