#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-whitehat-machine:latest}"

docker run --rm --platform=linux/amd64 "${IMAGE}" -lc '
set -euo pipefail

export NVM_DIR="${HOME}/.nvm"
. "${NVM_DIR}/nvm.sh"
export PATH="${PATH}:${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin"

commands=(
  "forge --version"
  "slither --version"
  "issue -h"
  "cargo --version"
  "halmos --version"
  "heimdall --version"
  "python3.9 --version"
  "pip3 --version"
  "solc-select -h"
  "ganache --version"
  "truffle --version"
  "julia --version"
  "npm --version"
  "nvm ls"
  "yarn --version"
  "solc --version"
  "anvil -h"
  "cast -h"
  "chisel -h"
  "cargo -h"
  "cargo-clippy -h"
  "cargo-fmt -h"
  "clippy-driver -h"
  "certoraRun --version"
  "manticore --version"
  "etheno --version"
  "brownie --version"
  "circom --version"
  "analyze4 -h"
  "nargo -h"
  "myth -h"
  "medusa --version"
  "pyrometer --version"
  "vyper --version"
  "ape -h"
  "evmasm -h"
  "pytest -h"
  "echidna --version"
  "quickpoc -h"
)

failures=0
for cmd in "${commands[@]}"; do
  if ! eval "${cmd}" >/tmp/tool-check.log 2>&1; then
    echo "Missing or broken tool: ${cmd}" >&2
    cat /tmp/tool-check.log >&2
    failures=$((failures + 1))
  fi
done

exit "${failures}"
'
