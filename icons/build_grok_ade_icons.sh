#!/usr/bin/env bash
# shellcheck disable=SC1091
# Install Grok ADE branding into src/stable before prepare_vscode copies resources.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

. "${ROOT_DIR}/utils.sh"
QUALITY="${VSCODE_QUALITY:-stable}"
ICON_DIR="${SCRIPT_DIR}/grok-ade"
STABLE="${ROOT_DIR}/src/${QUALITY}"

if [[ ! -d "${ICON_DIR}" ]]; then
  echo "grok-ade icon sources not found at ${ICON_DIR}" >&2
  exit 1
fi

mkdir -p \
  "${STABLE}/resources/linux" \
  "${STABLE}/resources/linux/rpm" \
  "${STABLE}/resources/win32" \
  "${STABLE}/resources/server" \
  "${STABLE}/src/vs/workbench/browser/media"

cp "${ICON_DIR}/grok_ade_clt.svg" "${STABLE}/src/vs/workbench/browser/media/code-icon.svg"
gsed -i 's|width="100" height="100"|width="1024" height="1024"|' "${STABLE}/src/vs/workbench/browser/media/code-icon.svg"

cp "${ICON_DIR}/grok_ade.svg" "${STABLE}/resources/linux/code.svg"

render_with_node() {
  if command -v node &>/dev/null; then
    node "${ICON_DIR}/render-icons.mjs" "${STABLE}" && return 0
  fi
  return 1
}

render_with_imagemagick() {
  command -v rsvg-convert &>/dev/null && command -v convert &>/dev/null
}

if render_with_node; then
  echo "Grok ADE icons rendered with Node (resvg)"
elif render_with_imagemagick; then
  echo "Grok ADE icons rendered with rsvg-convert + ImageMagick"
  rsvg-convert -w 512 -h 512 "${ICON_DIR}/grok_ade.svg" -o "${STABLE}/resources/linux/code.png"
  convert "${STABLE}/resources/linux/code.png" "${STABLE}/resources/linux/rpm/code.xpm"
  rsvg-convert -w 256 -h 256 "${ICON_DIR}/grok_ade.svg" -o /tmp/grok_ade_256.png
  convert /tmp/grok_ade_256.png -define icon:auto-resize=256,128,96,64,48,32,24,20,16 "${STABLE}/resources/win32/code.ico"
  convert -size 192x192 "${STABLE}/resources/linux/code.png" "${STABLE}/resources/server/code-192.png"
  convert -size 512x512 "${STABLE}/resources/linux/code.png" "${STABLE}/resources/server/code-512.png"
  cp "${STABLE}/resources/win32/code.ico" "${STABLE}/resources/server/favicon.ico"
  rsvg-convert -w 1024 -h 1024 "${ICON_DIR}/grok_ade.svg" -o /tmp/grok_ade_1024.png
  if command -v png2icns &>/dev/null && [[ -d "${STABLE}/resources/darwin" ]]; then
    convert /tmp/grok_ade_1024.png -resize 512x512 /tmp/grok_512.png
    convert /tmp/grok_ade_1024.png -resize 256x256 /tmp/grok_256.png
    convert /tmp/grok_ade_1024.png -resize 128x128 /tmp/grok_128.png
    png2icns "${STABLE}/resources/darwin/code.icns" /tmp/grok_ade_1024.png /tmp/grok_512.png /tmp/grok_256.png /tmp/grok_128.png
  fi
  rm -f /tmp/grok_ade_256.png /tmp/grok_ade_1024.png /tmp/grok_512.png /tmp/grok_256.png /tmp/grok_128.png
else
  echo "warn: no icon renderer available; SVG workbench/linux icons installed only" >&2
  echo "      run: pnpm --filter grok-ade-icons render  (or install rsvg-convert + ImageMagick)" >&2
fi

echo "Grok ADE branding assets installed under src/${QUALITY}/"