# Auditor-Toolbox
## Example build 
In a folder with the Dockerfile
```
docker build -t whitehat-machine .  
```

Then just run
```
docker run -it whitehat-machine 
```

Default password: 
```
ngmi
```

# Auditor Toolbox for Ethereum Smart Contracts

This Dockerfile creates an Ubuntu-based image with various tools and libraries for auditing Ethereum smart contracts. The image includes:

- Ubuntu Jammy base image
- Build tools, libraries, and common utilities
- Ethereum and Yices PPA repositories
- Node.js packages (Embark, Ganache, Truffle, etc.)
- Julia
- Rust, Cargo, and Foundry
- Noir language (Nargo)
- Circom
- Python developer tools (Pyevmasm, Py-solc-x, Vyper, Brownie)
- Trail of Bits tools (Slither, Echidna, Manticore, Etheno)
- Certora Prover and Java SDK 11

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

To use these installer scripts, run the interactive script `installer.sh` using the command `add2lbox` or `./scripts/installer.sh`.
