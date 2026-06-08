#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2129
# Grok ADE branded VSCodium build entrypoint.
#
# Windows: "C:\Program Files\Git\bin\bash.exe" ./dev/build-grok-ade.sh
#

export APP_NAME="Grok ADE"
export ASSETS_REPOSITORY="grok-ade/grok-ade"
export BINARY_NAME="grok-ade"
export CI_BUILD="no"
export GH_REPO_PATH="grok-ade/grok-ade"
export GLOBAL_DIRNAME="grok-ade"
export GROK_ADE_BUILD="yes"
export ORG_NAME="grok-ade"
export SHOULD_BUILD="yes"
export SKIP_ASSETS="yes"
export SKIP_BUILD="no"
export SKIP_SOURCE="no"
export VSCODE_LATEST="no"
export VSCODE_QUALITY="stable"
export VSCODE_SKIP_NODE_VERSION_CHECK="yes"
# No Grok ADE update server yet — disable auto-update until P1-12
export DISABLE_UPDATE="yes"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

if [[ -f "${ROOT_DIR}/icons/build_grok_ade_icons.sh" ]]; then
  bash "${ROOT_DIR}/icons/build_grok_ade_icons.sh"
fi

exec bash "${SCRIPT_DIR}/build.sh" "$@"