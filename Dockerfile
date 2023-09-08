# syntax=docker/dockerfile:1.3
# First stage for some cargo packages
# --- BUILDER STAGE ---
FROM ubuntu:jammy as builder

# Install necessary tools and dependencies.
RUN apt-get update && apt-get install -y curl git build-essential pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# Install rust and cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install foundry
RUN curl -L https://foundry.paradigm.xyz | bash
ENV PATH="/root/.foundry/bin:${PATH}"
RUN foundryup
# Install heimdall using bifrost
RUN curl -L http://get.heimdall.rs | bash && \
    . /root/.cargo/env && \
    /root/.bifrost/bin/bifrost

# Now, revert back to your main audit-toolbox stage
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
    ca-certificates \
    zip \
    unzip \
    libssl-dev \
    pkg-config && \
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
# ENV PATH="${PATH}:${HOME}/.local/bin:${HOME}/.vscode-server/bin/latest/bin"
ENV HOME="/home/whitehat"
ENV PATH="${HOME}/.bifrost/bin:${HOME}/.foundry/bin:${HOME}/.cargo/bin:${PATH}:${HOME}/.local/bin:${HOME}/.vscode-server/bin/latest/bin"
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

# Install cargo, rust, and foundry
RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 

# Previous installation of foundry binaries and heimdall binaries
#     curl -L https://foundry.paradigm.xyz | bash && \
#     curl -L http://get.heimdall.rs | bash && \
# PATH=$PATH:/home/whitehat/.cargo/bin && \
# PATH=$PATH:/home/whitehat/.bifrost/bin bifrost


# Set PATH
# ENV PATH="/home/whitehat/.foundry/bin:${PATH}"
# ENV PATH="/home/whitehat/.cargo/bin:${PATH}"
# ENV PATH="/home/whitehat/.bifrost/bin:/home/whitehat/.foundry/bin/:${PATH}"

# RUN foundryup

# Create the scripts directory
RUN mkdir -p /home/whitehat/scripts
# Create the templates directory
RUN mkdir -p /home/whitehat/templates

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

# Install latest version
RUN solc-select install 0.8.21  && \
    solc-select use 0.8.21

# Move the scripts to a directory in the PATH
RUN mv /home/whitehat/add2lbox /home/whitehat/.local/bin/

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

USER root
# RUN chown -R whitehat:whitehat /home/whitehat/
# Move scripts inside the folder and give permissions
COPY /scripts/*.sh /home/whitehat/scripts/
COPY /scripts/readme.md /home/whitehat/scripts/readme.md
COPY /templates/* /home/whitehat/templates/
RUN chmod +x /home/whitehat/scripts/*.sh && \
    # Set the owner and group of the scripts directory to whitehat
    chown -R whitehat:whitehat /home/whitehat/scripts
# Create the ASCII design for the Auditor Toolbox
COPY motd /etc/motd

RUN echo -e '\ncat /etc/motd\n' >> /etc/bash.bashrc

# Set Python 3.9 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Install pip for Python 3.9 and set it as the default
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.9 && \
    update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.9 1

USER whitehat

# Link scripts to ~/.local/bin for global access
RUN ln -s ~/scripts/certora_key_setup.sh ~/.local/bin/certoraKey && \
    ln -s ~/scripts/solc_docs.sh ~/.local/bin/solc-docs && \
    ln -s ~/scripts/issue_creator.sh ~/.local/bin/issue && \
    ln -s ~/scripts/update_scripts.sh ~/.local/bin/add2-update && \
    ln -s ~/.local/bin/add2lbox ~/.local/bin/add2 

# Setup user environment configurations 
RUN echo '# Point to the latest version of VS Code Remote server' >> ~/.bashrc && \
    echo 'if [ -d "${HOME}/.vscode-server/bin" ]; then' >> ~/.bashrc && \
    echo '    LATEST_VSCODE_SERVER_DIR=$(ls -td ${HOME}/.vscode-server/bin/*/ | head -n 1)' >> ~/.bashrc && \
    echo '    ln -sfn "${LATEST_VSCODE_SERVER_DIR}" ${HOME}/.vscode-server/bin/latest' >> ~/.bashrc && \
    echo 'fi' >> ~/.bashrc

# Append the specified PATH to .bashrc. This is a hotfix. TODO: https://github.com/Deivitto/auditor-docker/issues/31
RUN echo 'export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"' >> ~/.bashrc

# Copy binaries and other assets from the builder
COPY --from=builder /root/.bifrost/bin/* /home/whitehat/.bifrost/bin/
COPY --from=builder /root/.foundry/bin/* /home/whitehat/.foundry/bin/


# ENTRYPOINT ["/bin/bash"] is used to set the default command for the container to start a new Bash shell.
# This ensures that when the container is run, the user will be dropped into an interactive Bash shell by default.
ENTRYPOINT ["/bin/bash"]

# This Dockerfile includes the separation of the packages and their installation into separate scripts, 
# as well as the creation of the `readme.md` file in the `scripts` folder with instructions on how to use the scripts.
