# Auditor Toolbox Scripts

This interactive script assists with the installation of various tools commonly used for smart contract audits and other blockchain-related tasks. When executed, a menu will be displayed, allowing users to select which tools or packages they wish to install.

To start the toolbox installer, you can use:
- `add2lbox`
- Directly via `./scripts/installer.sh`

## Tools & Packages Available:

1. **Echidna** - Smart contract fuzzer.
2. **Certora Prover + Java SDK 11 (requirement)** - Formal verification tool for smart contracts.
    > Note: Replace `<premium_key>` with your actual Certora premium key during installation.
3. **Mythril** - Security analysis tool for Ethereum smart contracts.
4. **Manticore + Etheno** - Symbolic execution tool.
5. **Noir (Nargo)** - Privacy-preserving smart contract language.
6. **Circom** - Circuit compiler for zero-knowledge proofs.
7. **Python Developer Tools** - Includes Vyper, Ape Vyper, py-solc-x, and other Python tools related to Ethereum.
8. **VS Code Audit Extensions** - Installs common extensions used for smart contract audits when launched within VSCode.
9. **Medusa Fuzzer** - Fuzzer for binary applications.

For detailed instructions or issues, refer to the individual script files.
