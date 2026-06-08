#!/usr/bin/env bash
# Append grok-ade to product.json builtInExtensions (runs inside vscode/ during prepare).

set -e

node ../append-grok-ade-builtin.mjs