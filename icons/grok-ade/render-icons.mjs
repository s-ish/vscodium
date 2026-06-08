#!/usr/bin/env node
/**
 * Render Grok ADE platform icons from SVG sources.
 * Requires @resvg/resvg-js (optional devDependency in grok-ade monorepo root).
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync, copyFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const stableDir = process.argv[2];

if (!stableDir) {
  console.error('usage: node render-icons.mjs <src/stable>');
  process.exit(1);
}

let Resvg;
try {
  ({ Resvg } = require('@resvg/resvg-js'));
} catch {
  console.error('@resvg/resvg-js not installed — run: pnpm add -Dw @resvg/resvg-js');
  process.exit(1);
}

const here = dirname(fileURLToPath(import.meta.url));
const mainSvg = readFileSync(join(here, 'grok_ade.svg'));

function renderPng(svg, size) {
  const resvg = new Resvg(svg, {
    fitTo: { mode: 'width', value: size },
    background: 'transparent',
  });
  return resvg.render().asPng();
}

function writePng(path, png) {
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, png);
}

const linuxPng = renderPng(mainSvg, 512);
writePng(join(stableDir, 'resources/linux/code.png'), linuxPng);
writePng(join(stableDir, 'resources/server/code-192.png'), renderPng(mainSvg, 192));
writePng(join(stableDir, 'resources/server/code-512.png'), renderPng(mainSvg, 512));

// Minimal ICO: single 256px PNG with .ico extension (Electron accepts PNG-backed ICO on Windows dev builds)
const winIco = join(stableDir, 'resources/win32/code.ico');
writePng(winIco, renderPng(mainSvg, 256));
copyFileSync(winIco, join(stableDir, 'resources/server/favicon.ico'));

console.log('rendered linux PNG, server PNGs, and win32 ICO from grok_ade.svg');