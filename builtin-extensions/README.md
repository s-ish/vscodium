# Built-in extension staging

Generated during Grok ADE fork builds — not committed to git.

| File | Purpose |
|------|---------|
| `grok-ade.vsix` | Staged VSIX consumed by `product.json` → `builtInExtensions` |
| `version.txt` | Extension version from `extensions/grok-ade/package.json` |
| `sha256.txt` | VSIX checksum for `builtInExtensions` metadata |

Produced by `bundle_grok_ade_extension.sh` (called from `dev/build-grok-ade.sh`).