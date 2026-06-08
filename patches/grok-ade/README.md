# Grok ADE patches

Patches applied on top of VSCodium during the Grok ADE build (`GROK_ADE_BUILD=yes`).

Applied automatically from `prepare_vscode.sh` when building via `./dev/build-grok-ade.sh`.

## Branding (P1-02 / P1-03 — no patch file)

Handled by scripts instead of patches:

| Asset / config | Path |
|----------------|------|
| Product overlay | `product.grok-ade.json` |
| Branding setpaths | `prepare_grok_ade_branding.sh` |
| Post-build string rewrites | `prepare_grok_ade_postprocess.sh` |
| Icon sources | `icons/grok-ade/*.svg` |
| Icon install | `icons/build_grok_ade_icons.sh` |

## Built-in extension (P1-04 — scripts, no patch)

| Step | Path |
|------|------|
| Build + stage VSIX | `bundle_grok_ade_extension.sh` |
| Append `builtInExtensions` | `append_grok_ade_builtin.sh` (from `prepare_vscode.sh`) |
| Staged artifact | `builtin-extensions/grok-ade.vsix` |

## Planned patches (Phase 1 step 6+)

| Patch | Purpose |
|-------|---------|
| `welcome.patch` | First-run Grok CLI setup wizard |
| `default-layout.patch` | Agent sidebar open by default |

Open VSX gallery is already configured in `prepare_vscode.sh` (inherited from VSCodium).

See [docs/PHASE-1-FORK.md](../../../docs/PHASE-1-FORK.md) and [docs/FORK-MAINTENANCE.md](../../../docs/FORK-MAINTENANCE.md).