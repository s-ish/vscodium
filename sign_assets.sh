#!/usr/bin/env bash
# Post-package signing hook for Grok ADE release assets.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

case "${OS_NAME}" in
  windows)
    bash build/windows/sign.sh
    ;;
  linux)
    bash build/linux/gpg_sign.sh
    ;;
  osx)
    if [[ -n "${CERTIFICATE_OSX_P12_DATA:-}" ]]; then
      echo "macOS signing and notarization run during prepare_assets.sh"
    else
      echo "Skipping macOS signing (CERTIFICATE_OSX_P12_DATA not set)"
    fi
    ;;
  *)
    echo "Unknown OS_NAME=\"${OS_NAME}\"; skipping signing" >&2
    exit 1
    ;;
esac