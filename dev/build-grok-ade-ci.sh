#!/usr/bin/env bash
# Grok ADE CI build entrypoint (GitHub Actions).
# Sets CI_BUILD=yes so Windows packaging is deferred to the optional package job.
#
# Run from fork/vscodium after monorepo `pnpm install`:
#   ./dev/build-grok-ade-ci.sh

export CI_BUILD="${CI_BUILD:-yes}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "${SCRIPT_DIR}/build-grok-ade.sh" "$@"