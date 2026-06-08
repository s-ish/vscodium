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

## Welcome page (P1-06 — scripts + extension)

| Piece | Path |
|-------|------|
| Setup walkthrough | `extensions/grok-ade` → `contributes.walkthroughs` |
| CLI / auth checks | `extensions/grok-ade/src/welcome.ts` |
| Welcome announcements | `announcements-grok-ade.json` |
| Start entries (Open Grok / Set up) | `inject-grok-welcome.mjs` |

## Default layout (P1-07 — extension)

| Piece | Path |
|-------|------|
| Secondary side bar container | `extensions/grok-ade/package.json` → `viewsContainers.secondarySidebar` |
| Default visibility | `configurationDefaults.workbench.secondarySideBar.defaultVisibility` |
| First-run layout | `extensions/grok-ade/src/layout.ts` |
| Setting | `grok-ade.openAgentOnStartup` |

## Planned patches (Phase 1 step 8+)

| Patch | Purpose |
|-------|---------|
| _(none pending)_ | Windows/macOS/Linux CI builds next |

Open VSX gallery is already configured in `prepare_vscode.sh` (inherited from VSCodium).

See [docs/PHASE-1-FORK.md](../../../docs/PHASE-1-FORK.md) and [docs/FORK-MAINTENANCE.md](../../../docs/FORK-MAINTENANCE.md).