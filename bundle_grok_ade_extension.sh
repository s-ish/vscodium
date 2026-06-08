#!/usr/bin/env bash
# Build grok-ade from the monorepo and stage a VSIX for the VSCodium builtInExtensions pipeline.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MONOREPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
EXT_DIR="${MONOREPO_ROOT}/extensions/grok-ade"
STAGE_DIR="${SCRIPT_DIR}/builtin-extensions"

if [[ ! -f "${EXT_DIR}/package.json" ]]; then
  echo "grok-ade extension not found at ${EXT_DIR}" >&2
  exit 1
fi

if ! command -v pnpm &>/dev/null; then
  echo "pnpm is required to bundle grok-ade" >&2
  exit 1
fi

echo "Building grok-ade extension from ${MONOREPO_ROOT}..."
(
  cd "${MONOREPO_ROOT}"
  pnpm --filter grok-ade... run build
  pnpm --filter grok-ade run package
)

VSIX_PATH="$(find "${EXT_DIR}" -maxdepth 1 -name 'grok-ade-*.vsix' -type f | sort -V | tail -1)"
if [[ -z "${VSIX_PATH}" ]]; then
  echo "VSIX not produced under ${EXT_DIR}" >&2
  exit 1
fi

mkdir -p "${STAGE_DIR}"
cp -f "${VSIX_PATH}" "${STAGE_DIR}/grok-ade.vsix"

EXT_VERSION="$(node -e "const p=require('node:path');const f=p.join(process.argv[1],'package.json');console.log(require(f).version)" "${EXT_DIR}")"
echo "${EXT_VERSION}" > "${STAGE_DIR}/version.txt"

if command -v sha256sum &>/dev/null; then
  sha256sum "${STAGE_DIR}/grok-ade.vsix" | awk '{print $1}' > "${STAGE_DIR}/sha256.txt"
elif command -v shasum &>/dev/null; then
  shasum -a 256 "${STAGE_DIR}/grok-ade.vsix" | awk '{print $1}' > "${STAGE_DIR}/sha256.txt"
else
  echo "0000000000000000000000000000000000000000000000000000000000000000" > "${STAGE_DIR}/sha256.txt"
fi

echo "Staged ${STAGE_DIR}/grok-ade.vsix (v${EXT_VERSION})"