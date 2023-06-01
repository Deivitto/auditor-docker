# Auditor-Toolbox
## Basic build 
Clone the repo and cd in
```
git clone https://github.com/misirov/auditor-docker.git && \
cd auditor-docker
```

In the folder with the Dockerfile
```
docker build -t whitehat-machine .  
```

Then just run
```
docker run -it whitehat-machine 
```

## Share a folder
To run current folder inside the docker machine launch next command. Now, at the docker machine, a folder called /code will include current folder from parent operating system
```
docker run -it -v "$PWD":/code whitehat-machine
```

## 1 line command
Fast command to install it:
```
rm -rf auditor-docker && \
git clone https://github.com/misirov/auditor-docker.git && \
cd auditor-docker && \
docker build -t whitehat-machine . && \
docker run -it -d --name devops199 whitehat-machine
```

NOTE: This command uses -d to run the docker machine in the background, this is to use VSCode docker extension. After installing the extension, run command palette and type "Attach to running container...". This command will attach the instance of the machine to the VSCode instance.

## Credentials
Default password: 
```
ngmi
```

# Auditor Toolbox for Ethereum Smart Contracts

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

Additionally, the image sets up a user environment for a user named `whitehat` and includes several installer scripts to simplify the installation of various tools and libraries.

## Installer Scripts

Launch following scripts for fastly install packages
```
add2
```

or 

```
add2lbox
```

- py_developer_setup.sh: Installs Python packages (Pyevmasm, Py-solc-x, Vyper, Brownie)
- certora_setup.sh: Installs Certora Prover, Java SDK 11, and sets up Certora key and solc path
- advanced_tob_tools_setup.sh: Installs Trail of Bits tools (Manticore, Etheno)
- noir_setup.sh: Installs Noir language (Nargo)
- circom_setup.sh: Installs Circom
- echidna_installer.sh: Installs Homebrew and Echidna
- cargo_foundry_installer.sh   
- mythril_install.sh
- certora_key_setup.sh Sets the key (first parameter you send to the script)
To use these installer scripts, run the interactive script `installer.sh` using the command `add2lbox` or `./scripts/installer.sh`.

# Known issues and fixes
## Parent system out of time
**Issue**: Exit code 100

**Breaks**: on building, not even 2 seconds

```
ERROR: failed to solve: process "/bin/sh -c apt-get update &&     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends     build-essential     curl     git     vim     nano     z3     libz3-dev     ripgrep     gawk     libssl-dev     sudo     wget     software-properties-common     libudev-dev     locales     gpg-agent     dialog     procps     file     pandoc     texlive     ca-certificates &&     rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100
```

Launch next command to sync with google server your time and build again
```
sudo date -s "$(curl -s --head http://google.com | grep ^Date: | sed 's/Date: //g')
```
