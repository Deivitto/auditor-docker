# Auditor-Toolbox
## Intro
This auditor toolbox, intends to be a public repo where different toolboxs will araise for different goals and be in a 1 click install way. 

Actually, it's en alpha general version. I would like to keep it updated with new tools, new version and everything, feel free to ping me or suggest new improvements ^~^. 

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
git clone https://github.com/misirov/auditor-docker.git && \
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
git clone https://github.com/misirov/auditor-docker.git && \
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

>Note: Right now Rust, Cargo, and Foundry bundled in an installer. After running docker for the first time, launch:

```bash
add2
```
Select the first option and install: now you have foundry!

This Dockerfile creates an Ubuntu-based image with various tools and libraries for auditing Ethereum smart contracts. The image includes:

- Ubuntu Jammy base image (22.04)
- Ethereum related tools, libraries, dependencies, packages and common utilities
- Julia
- Rust, Cargo, and Foundry
- Noir language (Nargo)
- Circom
- Python developer tools (Pyevmasm, Py-solc-x, Vyper, Brownie)
- Trail of Bits tools (Slither, Echidna, Manticore, Etheno)
- Certora Prover and Java SDK 11
- Node Version Manager (NVM) + yarn + node + pnpm 
- Dependencies of [Spearbit Report Generator](https://github.com/spearbit-audits/report-generator-template)
- Pessimistic io slither detectors
- Vim solidity
- Solc-select
- Mythril

Additionally, the image sets up an environment for a user named `whitehat` and includes several installer scripts to simplify the installation of various tools and libraries.

## Installer Scripts

Launch following scripts for fastly install packages

```bash
add2
```

or 

```bash
add2lbox
```

- `$HOME/scripts/py_developer_setup.sh`: Installs Python packages (Pyevmasm, Py-solc-x, Vyper, Brownie)
- `$HOME/scripts/certora_setup.sh`: Installs Certora Prover, Java SDK 11, and sets up Certora key and `solc` path
- `$HOME/scripts/advanced_tob_tools_setup.sh`: Installs Trail of Bits tools (Manticore, Etheno)
- `$HOME/scripts/noir_setup.sh`: Installs Noir language (Nargo)
- `$HOME/scripts/circom_setup.sh`: Installs Circom
- `$HOME/scripts/echidna_installer.sh`: Installs Homebrew and Echidna
- `$HOME/scripts/cargo_foundry_installer.sh`
- `$HOME/scripts/mythril_install.sh`
- `$HOME/scripts/certora_key_setup.sh`: Sets the key needed to run Certora Prover, provided as the first parameter to the script.

To use these installer scripts, run the interactive script `installer.sh` using the command `add2lbox` or `$HOME/scripts/installer.sh`.

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

Use this command to append to the file `.bashrc` (or just copy paste the content inside to the file)
```bash
echo "VSCODE_SSH_BIN=$(echo "$BROWSER" | sed -e 's/\/helpers\/browser.sh//g')
alias code='$VSCODE_SSH_BIN/remote-cli/code'" >> ~/.bashrc 
```

Then source it
```bash
source ~/.bashrc 
```

