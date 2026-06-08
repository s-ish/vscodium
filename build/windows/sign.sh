#!/usr/bin/env bash
# Authenticode-sign Windows installers when WINDOWS_CERTIFICATE_PFX_DATA is set.

set -euo pipefail

if [[ -z "${WINDOWS_CERTIFICATE_PFX_DATA:-}" ]]; then
  echo "Skipping Authenticode signing (WINDOWS_CERTIFICATE_PFX_DATA not set)"
  exit 0
fi

if [[ ! -d assets ]]; then
  echo "assets/ not found; nothing to sign" >&2
  exit 1
fi

PFX_FILE="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/grok-ade-signing.pfx"
echo "${WINDOWS_CERTIFICATE_PFX_DATA}" | base64 --decode > "${PFX_FILE}"

SIGNTOOL=""
if command -v signtool.exe &>/dev/null; then
  SIGNTOOL="signtool.exe"
else
  for candidate in \
    "/c/Program Files (x86)/Windows Kits/10"/bin/*/x64/signtool.exe \
    "/c/Program Files/Windows Kits/10"/bin/*/x64/signtool.exe; do
    # shellcheck disable=SC2086
    if [[ -f ${candidate} ]]; then
      SIGNTOOL="${candidate}"
      break
    fi
  done
fi

if [[ -z "${SIGNTOOL}" ]]; then
  echo "signtool.exe not found; install Windows SDK signing tools" >&2
  rm -f "${PFX_FILE}"
  exit 1
fi

TIMESTAMP_URL="${WINDOWS_TIMESTAMP_URL:-http://timestamp.digicert.com}"
SIGNED=0

shopt -s nullglob
for artifact in assets/*.exe assets/*.msi; do
  echo "Signing ${artifact}"
  "${SIGNTOOL}" sign \
    /f "${PFX_FILE}" \
    /p "${WINDOWS_CERTIFICATE_PFX_PASSWORD:-}" \
    /tr "${TIMESTAMP_URL}" \
    /td sha256 \
    /fd sha256 \
    "${artifact}"
  SIGNED=$((SIGNED + 1))
done
shopt -u nullglob

rm -f "${PFX_FILE}"

if [[ "${SIGNED}" -eq 0 ]]; then
  echo "No .exe or .msi files found in assets/"
else
  echo "Signed ${SIGNED} Windows artifact(s)"
fi