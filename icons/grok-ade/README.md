# Grok ADE icon sources

Original branding assets for the Grok ADE desktop app (not the xAI Grok wordmark).

## Design

- Dark rounded square (`#09090B` → `#18181B`)
- Amber accent gradient (`#FB923C` → `#FDE68A`) — evokes Grok/xAI dark UI without copying trademarked logos
- Orbital arc + bar + nodes — abstract “G” suggesting agent orbit / IDE

## Files

| File | Use |
|------|-----|
| `grok_ade.svg` | App icon source (Linux PNG, Windows ICO, server) |
| `grok_ade_clt.svg` | Workbench `code-icon.svg` |
| `grok_ade_w80_b8.svg` | macOS document-type icons (with ring) |
| `render-icons.mjs` | Node renderer (`@resvg/resvg-js`) |

## Render

From monorepo root:

```bash
pnpm run icons:render
```

Or during Grok ADE fork build:

```bash
cd fork/vscodium
./icons/build_grok_ade_icons.sh
```

Activity bar icon (24×24): `extensions/grok-ade/media/grok-icon.svg`