# Auditor-Toolbox
## Intro
This auditor toolbox, intends to be a public repo where different toolboxs will araise for different goals and to be in a one-click install way. 

Beta version of Auditor Toolbox is ready. I would like to keep it updated with new tools, new versions and everything, feel free to ping me or suggest new improvements. 

>Disclaimer: Still under testing due to some bugs

## Index

1. Auditor Toolbox Setup
    * [1.1 Basic build](#basic-build)
    * [1.2 Share a directory](#share-a-directory)
    * [1.3 One-line command](#one-line-command)
    * [1.4 To relaunch the docker instance](#to-relaunch-the-docker-instance)
    * [1.5 Credentials](#credentials)
2. [Auditor Toolbox for Ethereum Smart Contracts](#auditor-toolbox-for-ethereum-smart-contracts)
3. [Troubleshooting](#troubleshooting)
    * [3.1 Parent system out of time](#parent-system-out-of-time)
    * [3.2 `code` not working](#code-not-working)

## Basic build 
Clone the repo and `cd` into it
```bash
git clone https://github.com/Deivitto/auditor-docker.git && \
cd auditor-docker
```

Then, within the directory where the Dockerfile is
```bash
docker build -t whitehat-machine .  
```

Then just run
```bash
docker run -it whitehat-machine 
```

## Share a directory
To run the current directory inside the docker machine launch a command like this one
```bash
docker run -it -v "$PWD":/code whitehat-machine
```

Now, at the docker machine, a directory called `/code` will include the current directory from parent operating system.

## One-line command

The fast command to install the machine is
```bash
rm -rf auditor-docker && \
git clone https://github.com/Deivitto/auditor-docker.git && \
cd auditor-docker && \
docker build -t whitehat-machine . && \
docker run -it -d --name devops199 whitehat-machine
```

>NOTE: This command uses `-d` to run the docker machine in the background, with the objective of using the VSCode docker extension.
>After installing the extension, run the command palette and type `Attach to running container...`. This command will attach the instance of the machine to the VSCode instance.

## To relaunch the docker instance
Run `docker start` with the name of your instance. If the [one-line command](#one-line-command) was used, this will be
```bash
docker start devops199
```

## To increase maximum stack size (i.e. to use manticore)
```bash
docker run -it --ulimit stack=100000000:100000000 -d --name devops199 whitehat-machine 
```

## Credentials
The default password: 
```bash
ngmi
```

# Auditor Toolbox for Ethereum Smart Contracts

Easily deploy an auditing environment for Ethereum smart contracts using this Docker image.

### Quick Start

Execute the add2 command:

```bash
add2
```

Select the option you want to install and voila, you're all set!

## Features
### Base Setup:
- **Operating System**: Ubuntu Jammy (22.04)
- **Utilities**: Git, Curl/wget, gawk/ripgrep, z3, pandoc, openssh-client, texlive, solidity plugins for Vim, etc.
### Languages & Frameworks:
- **Python**: Version 3.9
- **Rust**: Comprehensive setup with Cargo
- **Julia**: Built-in support.
- **Noir**: Support for the Noir language (Nargo).
- **Circom**: Framework for zkSNARK circuits.
###  Ethereum Development:
A set of most of the famous tools in the ecosystem by different authors.
- **Ethereum** dependencies.
- **Foundry** as modular toolkit for Ethereum application development written in Rust. It includes: **Forge**, **Anvil**, **Cast**, and **Chisel**. Author Paradigm.
- **Halmos** for Symbolic Bounded Model Checker for Ethereum Smart Contracts Bytecode. Author a16z.
- **Heimdall** for advanced EVM smart contract toolkit specialized in bytecode analysis. Author Jon-Becker.
- **Slither**, **Echidna**, **Medusa Fuzzer**, **Manticore**, and **Etheno**, **solc-select** and **crytic compile**. Author Trail of Bits.
- **Extra Slither detectors**, specialized **detectors** for Slither. Author Pessimistic.io.
- **Prover** tool for symbolic analysis. Author Certora.
- **Mythril** for smart contract analysis. Author Consensys.
- **Spearbit Report Generator**, all needed **dependencies** to use the report generator in Spearbit audits
- **Python developer kit**: It includes **Vyper**, **Ape-Vyper**, **Py-solc-x** and **pyevwasm**, can be found in `add2`
### Node.js Development:
- **NVM**: Node Version Manager to switch between different Node.js versions.
- **Node**: Long Term Support (LTS) version.
- **Package** Managers: npm, yarn, and pnpm.

For more info go to the [table](https://github.com/Deivitto/auditor-docker/wiki/Features) with all the features or to the [references](https://github.com/Deivitto/auditor-docker/wiki/References) page in the wiki, where all the links to the packages are included.

Additionally, the image sets up an environment for a user named `whitehat` and includes several installer scripts to simplify the installation of various tools and libraries.

## Scripts

The toolbox includes scripts to fast install multiple packages, utilities or dependencies that maybe not all auditors but a considerable part may use. To launch the install script:

```bash
add2
```

or 

```bash
add2lbox
```

It also includes a script to update the scripts and templates folder with the latest version of this github:

```bash
add2-update
```

Also, it includes a script to create issues fastly without leaving the docker enviornment. Example:

```bash
issue c4 -n UncheckedTransfer -vim
```

That would create an issue with the Code4rena template, with name UncheckedTransfer and it is opened at the end using vim. For more info run `issue -h`

# Troubleshooting
## Parent system out of time
**Issue**: Exit code 100

**Breaks**: on building, not even 2 seconds

```bash
ERROR: failed to solve: process "/bin/sh -c apt-get update &&     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends     build-essential     curl     git     vim     nano     z3     libz3-dev     ripgrep     gawk     libssl-dev     sudo     wget     software-properties-common     libudev-dev     locales     gpg-agent     dialog     procps     file     pandoc     texlive     ca-certificates &&     rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100
```

Launch the next command to sync your time with the Google server and build again
```bash
sudo date -s "$(curl -s --head http://google.com | grep ^Date: | sed 's/Date: //g')"
```
## `code` not working
**Issue**: `code` command not found

**Breaks**: on use. Doesn't recognize `code`

### Solution 1: Sometimes work

Use this command to append to the file `.bashrc` an alias to find the vscode `code` command
```bash
echo "VSCODE_SSH_BIN=$(echo "$BROWSER" | sed -e 's/\/helpers\/browser.sh//g')
alias code='$VSCODE_SSH_BIN/remote-cli/code'" >> ~/.bashrc 
```

Then source it
```bash
source ~/.bashrc 
```

### Solution 2
This was pretty more annoying, but totally worked
- Step 1: Inside the docker machine, remove the /.vscode-server. Run:
```bash
rm -r ~/.vscode-server # you can also run mv ~/.vscode-server ~/.backup-vscode-server
```
- Step 2: Outside the docker machine, shutdown wsl what is linked with docker, run:
```bash
wsl --shutdown
```

This will first make docker desktop look like there are no instances of the machines, but after restarting docker desktop, it will show them again.

- Step 3: Restart docker desktop (in case you are using it)
- Step 4: Newly launch the command palette and attach the docker image from vscode and enjoy having `code` ready again :P

