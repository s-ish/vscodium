#!/usr/bin/env bash
# Detached-armor GPG signatures for Linux release packages.

set -euo pipefail

if [[ -z "${GPG_PRIVATE_KEY:-}" ]]; then
  echo "Skipping GPG signing (GPG_PRIVATE_KEY not set)"
  exit 0
fi

if [[ ! -d assets ]]; then
  echo "assets/ not found; nothing to sign" >&2
  exit 1
fi

if ! command -v gpg &>/dev/null; then
  echo "gpg is required for package signing" >&2
  exit 1
fi

GPG_HOME="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/grok-ade-gpg"
mkdir -p "${GPG_HOME}"
chmod 700 "${GPG_HOME}"
export GNUPGHOME="${GPG_HOME}"

echo "${GPG_PRIVATE_KEY}" | gpg --batch --import

GPG_ARGS=(--batch --yes --detach-sign --armor)
if [[ -n "${GPG_PASSPHRASE:-}" ]]; then
  GPG_ARGS+=(--pinentry-mode loopback --passphrase "${GPG_PASSPHRASE}")
fi

SIGNED=0
for artifact in assets/*; do
  [[ -f "${artifact}" ]] || continue
  case "${artifact}" in
    *.asc | *.sha256 | *.sha1) continue ;;
  esac
  echo "GPG signing ${artifact}"
  gpg "${GPG_ARGS[@]}" "${artifact}"
  SIGNED=$((SIGNED + 1))
done

shred -u "${GPG_HOME}/private-keys-v1.d"/* 2>/dev/null || true
rm -rf "${GPG_HOME}"

if [[ "${SIGNED}" -eq 0 ]]; then
  echo "No signable files found in assets/"
else
  echo "Created detached signatures for ${SIGNED} Linux artifact(s)"
fi