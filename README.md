# Auditor-Toolbox
## Intro
The Auditor Toolbox essential goal is to pack all the essential auditor tools into a single Docker Image!

Our beta version is up and running! I'm keen on keeping it fresh with the latest tools and versions. Got suggestions or updates? Don't hesitate to reach out or pitch in your ideas!


## Index

1. Auditor Toolbox Setup
    * [1.1 Basic build](#basic-build)
    * [1.2 Share a directory](#share-a-directory)
    * [1.3 One-line command](#one-line-command)
    * [1.4 To relaunch the docker instance](#to-relaunch-the-docker-instance)
    * [1.5 Credentials](#credentials)
2. [Auditor Toolbox for Ethereum Smart Contracts](#auditor-toolbox-for-ethereum-smart-contracts)
3. [Scripts](#scripts)
4. [Troubleshooting](#troubleshooting)

## One-line command

The fast command to install the machine is
```bash
rm -rf auditor-docker && \
git clone https://github.com/Deivitto/auditor-docker.git && \
cd auditor-docker && \
git fetch origin && \
git checkout -b OpenSense_Demo origin/OpenSense_Demo && \
docker build -t open-sense-demo . && \
docker run -it  -d --name machine1 open-sense-demo # for manticore use --ulimit stack=100000000:100000000
```

>NOTE: This command uses `-d` to run the docker machine in the background, with the objective of using the VSCode docker extension.
>After installing the extension, run the command palette and type `Attach to running container...`. This command will attach the instance of the machine to the VSCode instance.

## One use
```bash
docker run -it --rm --name temporal_machine open-sense-demo
```

## To relaunch the docker instance
Run `docker start` with the name of your instance. If the [one-line command](#one-line-command) was used, this will be
```bash
docker start machine1
```

> You can also use docker interface

## Demo flows
### Before uses
- What's inside?

### Config / Installations
For the very start, let's install some tools
```bash
add2
```

Alternatively we can just install them as scripts
```bash
bash scripts/analyzer_installer.sh
bash scripts/medusa_fuzzer.sh
bash scripts/mythril_install.sh
bash scripts/pyrometer.sh
bash scripts/versions.sh
```

### Extra: Update your scripts
```bash
rm scripts/versions.sh
add2-update
```

### Repo set and compile
```bash
git clone https://github.com/code-423n4/2023-01-popcorn
cd 2023-01-popcorn
forge install
yarn install
cp env.example .env
solc-select install 0.8.15
solc-select use 0.8.15
```

### Get the scope of the contract
- Surya: Solidity Metrics

### Analyzers
```bash
mkdir demo_outputs
slither . --checklist --config-file > demo_outputs/slither_output.md
analyze4 src 
myth analyze --solc-json remappings.json --solv 0.8.15 --execution-timeout 1200 > demo_outputs/myth_output.md

```

### Write issues
```bash
issue c4 -n DemoIssue1 -code
```

### Fuzzers
```bash
# forge test
forge build
forge test --no-match-contract 'Abstract' --gas-report
medusa . WIP
echidna . WIP
```
### Formal verification
```bash
halmos
```
### Others
```bash
pyro WIP
heimdall WIP
```

### Local Ethereum Node 
```bash
ganache
anvil
```

> Anvil example use: https://nader.mirror.xyz/6Mn3HjrqKLhHzu2balLPv4SqE5a-oEESl4ycpRkWFsc

### Not included for the demo
- Certora Prover
- Manticore
- Brownie
- Circom
- Nargo
- Embark
- Python tools

## Credentials
The default password: 
```bash
ngmi
```

# Time metrics:
<details>
  <summary>Total: [+] Building 589.3s</summary>
  
```bash
$ rm -rf auditor-docker && \
git clone https://github.com/Deivitto/auditor-docker.git && \
cd auditor-docker && \
git fetch origin && \
git checkout -b OpenSense_Demo origin/OpenSense_Demo && \
docker build -t open-sense-demo . && \
docker run -it  -d --name machine1 open-sense-demo
Cloning into 'auditor-docker'...
remote: Enumerating objects: 628, done.
remote: Counting objects: 100% (254/254), done.
remote: Compressing objects: 100% (154/154), done.
remote: Total 628 (delta 161), reused 153 (delta 100), pack-reused 374
Receiving objects:  99% (622/628)
Receiving objects: 100% (628/628), 181.93 KiB | 1.80 MiB/s, done.
Resolving deltas: 100% (353/353), done.
Switched to a new branch 'OpenSense_Demo'
branch 'OpenSense_Demo' set up to track 'origin/OpenSense_Demo'.

[+] Building 589.3s (45/45) FINISHED
 => [internal] load build definition from Dockerfile                                                   0.1s
 => => transferring dockerfile: 7.78kB                                                                 0.0s
 => [internal] load .dockerignore                                                                      0.0s
 => => transferring context: 2B                                                                        0.0s
 => resolve image config for docker.io/docker/dockerfile:1.3                                           1.8s
 => docker-image://docker.io/docker/dockerfile:1.3@sha256:42399d4635eddd7a9b8a24be879d2f9a930d0ed040a  0.9s
 => => resolve docker.io/docker/dockerfile:1.3@sha256:42399d4635eddd7a9b8a24be879d2f9a930d0ed040a6132  0.0s
 => => sha256:42399d4635eddd7a9b8a24be879d2f9a930d0ed040a61324cfdf59ef1357b3b2 2.00kB / 2.00kB         0.0s
 => => sha256:93f32bd6dd9004897fed4703191f48924975081860667932a4df35ba567d7426 528B / 528B             0.0s
 => => sha256:e532695ddd93ca7c85a816c67afdb352e91052fab7ac19a675088f80915779a7 1.21kB / 1.21kB         0.0s
 => => sha256:24a639a53085eb680e1d11618ac62f3977a3926fedf5b8471ace519b8c778030 9.67MB / 9.67MB         0.7s
 => => extracting sha256:24a639a53085eb680e1d11618ac62f3977a3926fedf5b8471ace519b8c778030              0.1s
 => [internal] load build definition from Dockerfile                                                   0.0s
 => [internal] load .dockerignore                                                                      0.0s
 => [internal] load metadata for docker.io/library/ubuntu:jammy                                        1.3s
 => [audit-toolbox  1/31] FROM docker.io/library/ubuntu:jammy@sha256:aabed3296a3d45cede1dc866a24476c4  3.4s
 => => resolve docker.io/library/ubuntu:jammy@sha256:aabed3296a3d45cede1dc866a24476c4d7e093aa806263c2  0.0s
 => => sha256:aabed3296a3d45cede1dc866a24476c4d7e093aa806263c27ddaadbdce3c1054 1.13kB / 1.13kB         0.0s
 => => sha256:b492494d8e0113c4ad3fe4528a4b5ff89faa5331f7d52c5c138196f69ce176a6 424B / 424B             0.0s
 => => sha256:c6b84b685f35f1a5d63661f5d4aa662ad9b7ee4f4b8c394c022f25023c907b65 2.30kB / 2.30kB         0.0s
 => => sha256:445a6a12be2be54b4da18d7c77d4a41bc4746bc422f1f4325a60ff4fc7ea2e5d 29.54MB / 29.54MB       2.6s
 => => extracting sha256:445a6a12be2be54b4da18d7c77d4a41bc4746bc422f1f4325a60ff4fc7ea2e5d              0.6s
 => [internal] load build context                                                                      0.1s
 => => transferring context: 31.72kB                                                                   0.0s
 => [audit-toolbox  2/31] RUN apt-get update &&     DEBIAN_FRONTEND=noninteractive apt-get install   307.7s
 => [builder 2/6] RUN apt-get update && apt-get install -y curl git build-essential pkg-config libss  73.4s
 => [builder 3/6] RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y         54.5s
 => [builder 4/6] RUN curl -L https://foundry.paradigm.xyz | bash                                      1.8s
 => [builder 5/6] RUN foundryup                                                                       10.0s
 => [builder 6/6] RUN curl -L http://get.heimdall.rs | bash &&     . /root/.cargo/env &&     /root/  239.2s
 => [audit-toolbox  3/31] RUN add-apt-repository -y ppa:ethereum/ethereum &&     add-apt-repository   45.0s
 => [audit-toolbox  4/31] RUN curl -fsSL https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-  22.0s
 => [audit-toolbox  5/31] RUN useradd -m -G sudo whitehat &&     echo 'whitehat ALL=(ALL) NOPASSWD: A  0.6s
 => [audit-toolbox  6/31] WORKDIR /home/whitehat                                                       0.0s
 => [audit-toolbox  7/31] RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.s  2.9s
 => [audit-toolbox  8/31] RUN . "/home/whitehat/.nvm/nvm.sh" &&     nvm install --lts &&     nvm al  110.9s
 => [audit-toolbox  9/31] RUN curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -  28.6s
 => [audit-toolbox 10/31] RUN mkdir -p /home/whitehat/scripts                                          0.5s
 => [audit-toolbox 11/31] RUN mkdir -p /home/whitehat/templates                                        0.5s
 => [audit-toolbox 12/31] RUN echo '#!/bin/bash\n/home/whitehat/scripts/installer.sh' > /home/whiteha  0.6s
 => [audit-toolbox 13/31] RUN chmod +x /home/whitehat/add2lbox                                         0.6s
 => [audit-toolbox 14/31] RUN python3.9 -m pip install --no-cache-dir pip setuptools wheel             2.4s
 => [audit-toolbox 15/31] RUN python3.9 -m pip install --no-cache-dir     solc-select     slither-an  28.8s
 => [audit-toolbox 16/31] RUN git clone https://github.com/tomlion/vim-solidity.git ~/.vim/pack/plugi  1.3s
 => [audit-toolbox 17/31] RUN solc-select install 0.8.21  &&     solc-select use 0.8.21                3.3s
 => [audit-toolbox 18/31] RUN mv /home/whitehat/add2lbox /home/whitehat/.local/bin/                    0.6s
 => [audit-toolbox 19/31] COPY /scripts/*.sh /home/whitehat/scripts/                                   0.0s
 => [audit-toolbox 20/31] COPY /scripts/readme.md /home/whitehat/scripts/readme.md                     0.0s
 => [audit-toolbox 21/31] COPY /templates/* /home/whitehat/templates/                                  0.0s
 => [audit-toolbox 22/31] RUN chmod +x /home/whitehat/scripts/*.sh &&     chown -R whitehat:whitehat   0.5s
 => [audit-toolbox 23/31] COPY motd /etc/motd                                                          0.0s
 => [audit-toolbox 24/31] RUN echo -e '\ncat /etc/motd\n' >> /etc/bash.bashrc                          0.5s
 => [audit-toolbox 25/31] RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3  0.5s
 => [audit-toolbox 26/31] RUN curl https://bootstrap.pypa.io/get-pip.py | python3.9 &&     update-alt  6.5s
 => [audit-toolbox 27/31] RUN ln -s ~/scripts/certora_key_setup.sh ~/.local/bin/certoraKey &&     ln   0.6s
 => [audit-toolbox 28/31] RUN echo '# Point to the latest version of VS Code Remote server' >> ~/.bas  0.5s
 => [audit-toolbox 29/31] RUN echo 'export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node  0.6s
 => [audit-toolbox 30/31] COPY --from=builder /root/.bifrost/bin/* /home/whitehat/.bifrost/bin/        0.1s
 => [audit-toolbox 31/31] COPY --from=builder /root/.foundry/bin/* /home/whitehat/.foundry/bin/        0.2s
 => exporting to image                                                                                14.6s
 => => exporting layers                                                                               14.6s
 => => writing image sha256:ff21d8e4a4fe377a7551449afdf9e4d420b9c0ded70be7b3a577c42c4120737a           0.0s
 => => naming to docker.io/library/open-sense-demo                                                     0.0s
```
</details>

# Auditor Toolbox for Ethereum Smart Contracts

Easily deploy an auditing environment for Ethereum smart contracts using this Docker image.

### Quick Start

After the docker is builded, you may be missing some tool not installed by default, if so, execute the `add2` command:

```bash
add2
```

Select the option you want to install and voila, you're all set!

## Features
### Base Setup:
- **Operating System**: Ubuntu Jammy (22.04)
- **Utilities**: Git, Curl/wget, gawk/ripgrep, z3, pandoc, openssh-client, texlive, solidity plugins for Vim, etc.
- **Ethereum** dependencies.
### Languages & Frameworks:
- **Python**: Version 3.9
- **Rust**: Comprehensive setup with Cargo
- **Julia**: Built-in support.
- **Noir**: Support for the Noir language (Nargo).
- **Circom**: Framework for zkSNARK circuits.
- **Solidity**: Smart contracts language.
- **Vyper**: Smart contracts language.
###  Ethereum Development:
A set of most of the famous tools in the ecosystem by different authors.
- **Foundry** as modular toolkit for Ethereum application development written in Rust. It includes: **Forge**, **Anvil**, **Cast**, and **Chisel**. Author Paradigm.
- **Halmos** for Symbolic Bounded Model Checker for Ethereum Smart Contracts Bytecode. Author a16z.
- **Heimdall** for advanced EVM smart contract toolkit specialized in bytecode analysis. Author Jon-Becker.
- **Slither**, **Echidna**, **Medusa Fuzzer**, **Manticore**, and **Etheno**, **solc-select** and **crytic compile**. Author Trail of Bits.
- **Extra Slither detectors**, specialized **detectors** for Slither. Author Pessimistic.io.
- **Prover** tool for symbolic analysis. Author Certora.
- **Mythril** for smart contract analysis. Author Consensys.
- **Spearbit Report Generator**, all needed **dependencies** to use the report generator in Spearbit audits
- **Python developer kit**: It includes **Vyper**, **Ape-Vyper**, **Py-solc-x** and **pyevwasm**, can be found in `add2`
- **4nalyz3r**: A comprehensive static analysis tool for smart contracts. Author: Picodes.
- **Ganache** and **Truffle**: Tools such as running a personal blockchain, development environment, testing framework, and asset pipeline for Ethereum. Author: Truffle Suite.
- **Pyrometer**: is a mix of symbolic execution, abstract interpretation, and static analysis. Author: nascentxyz
- **Brownie**: Python-based development and testing framework for smart contracts targeting the Ethereum Virtual Machine.

### Node.js Development:
- **NVM**: Node Version Manager to switch between different Node.js versions.
- **Node**: Long Term Support (LTS) version.
- **Package** Managers: npm, yarn, and pnpm.

For more info go to the [table](https://github.com/Deivitto/auditor-docker/wiki/Features) with all the features or to the [references](https://github.com/Deivitto/auditor-docker/wiki/References) page in the wiki, where all the links to the packages are included.

Additionally, the image sets up an environment for a user named `whitehat` and includes several installer scripts to simplify the installation of various tools and libraries.

## Scripts
### add2
The toolbox includes scripts to fast install multiple packages, utilities or dependencies that maybe not all auditors but a considerable part may use. To launch the install script:

```bash
add2 # this is a shortcut of add2lbox
```

### add2-update
It also includes a script to update the scripts and templates folder with the latest version of this github:

```bash
add2-update
```
### issue
Also, it includes a script to create issues fastly without leaving the docker enviornment. Example:

```bash
issue c4 -n UncheckedTransfer -vim
```

That would create an issue with the Code4rena template, with name UncheckedTransfer and it is opened at the end using vim. For more info run `issue -h`
### analyze4
`analyze4` is a wrapper designed to seamlessly and intuitively execute the `yarn analyze` command from .4nalyz3r, making the process more transparent for the user." To use it, just go to the project you want to analyze, and run something like:

```bash
analyze4 src -nano
```
This would get the relative path of the src folder where all the contracts are (if the contracts folder is named "contracts", just change the word) and will launch 4nalyz3r against that code. The output will be given in the current folder and in this case, opened with nano text editor.


# Troubleshooting
For general information, go to [Troubleshooting](https://github.com/Deivitto/auditor-docker/wiki/Troubleshooting) section in the wiki
- [v0.0.1: `yarn`: command not found](https://github.com/Deivitto/auditor-docker/wiki/Troubleshooting#yarn-command-not-found)
- [Parent system out of time](https://github.com/Deivitto/auditor-docker/wiki/Troubleshooting#parent-system-out-of-time)
- [`code` not working](https://github.com/Deivitto/auditor-docker/wiki/Troubleshooting#code-not-working)
