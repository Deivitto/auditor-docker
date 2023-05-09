python3.9 -m pip install     manticore     etheno     "eth-abi>=4.0.0"     "eth-account>=0.8.0"     "eth-hash[pycryptodome]>=0.5.1"     "eth-typing>=3.0.0"     "eth-utils>=2.1.0"     "crytic-compile>=0.3.1,<0.4.0"     "web3>=6.0.0" && \
# Install global npm packages
npm install --omit=dev --global --force \
    embark \
    @trailofbits/embark-contract-info \
