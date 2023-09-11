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
