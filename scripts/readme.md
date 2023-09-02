# Auditor Toolbox Scripts

This interactive script assists with the installation of various tools commonly used for smart contract audits and other blockchain-related tasks. When executed, a menu will be displayed, allowing users to select which tools or packages they wish to install.

To start the toolbox installer, you can use:
- `add2lbox`
- Directly via `./scripts/installer.sh`

To know more
- `add2 -h`

## Tools & Packages Available:

1. **Certora Prover + Java SDK 11 (requirement)** - Formal verification tool for smart contracts.
    > Note: Replace `<premium_key>` with your actual Certora premium key during installation.
2. **Echidna** - Smart contract fuzzer.
3. **Mythril** - Security analysis tool for Ethereum smart contracts.
4. **Manticore** - Symbolic execution tool for smart contracts.
5. **Medusa Fuzzer** - Fuzzer for binary applications.
6. **4nalyz3r** - Smart contract analyzer.
7. **Pyrometer** - Smart contract performance tester.
8. **Brownie** - Python-based development environment and testing framework for Ethereum.
9. **Etheno** - JSON-RPC multiplexer, analysis tool wrapper, and test integration.
10. **Noir (Nargo)** - Privacy-preserving smart contract language.
11. **Circom** - Circuit compiler for zero-knowledge proofs.
12. **Embark** - Framework for serverless Decentralized Applications using Ethereum.
13. **Python Developer Tools** - Includes Vyper, Ape Vyper, py-solc-x, and other Python tools related to Ethereum.
14. **VS Code Audit Extensions** - Installs common extensions used for smart contract audits when launched within VSCode.

For detailed instructions or issues, refer to the individual script files.
