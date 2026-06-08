#!/usr/bin/env node
/**
 * Append grok-ade to product.json builtInExtensions without replacing upstream entries.
 */
import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const vscodeDir = process.cwd();
const productPath = join(vscodeDir, 'product.json');
const stageDir = join(here, 'builtin-extensions');

const vsixPath = '../builtin-extensions/grok-ade.vsix';
if (!existsSync(join(vscodeDir, vsixPath))) {
  console.warn(`warn: ${vsixPath} missing — run bundle_grok_ade_extension.sh before building`);
  process.exit(0);
}

const version = existsSync(join(stageDir, 'version.txt'))
  ? readFileSync(join(stageDir, 'version.txt'), 'utf8').trim()
  : '0.0.1';

const sha256 = existsSync(join(stageDir, 'sha256.txt'))
  ? readFileSync(join(stageDir, 'sha256.txt'), 'utf8').trim()
  : '0'.repeat(64);

const product = JSON.parse(readFileSync(productPath, 'utf8'));
product.builtInExtensions ??= [];

if (!product.builtInExtensions.some((e) => e.name === 'grok-ade')) {
  product.builtInExtensions.push({
    name: 'grok-ade',
    version,
    vsix: vsixPath,
    repo: 'https://github.com/grok-ade/grok-ade',
    sha256,
    metadata: {
      id: 'grok-ade.grok-ade',
      publisherId: {
        publisherId: 'f8e7d6c5-b4a3-4291-8e7d-6c5b4a392817',
        publisherName: 'grok-ade',
        displayName: 'Grok ADE',
        flags: '',
      },
      publisherDisplayName: 'Grok ADE',
    },
  });
}

writeFileSync(productPath, `${JSON.stringify(product, null, 2)}\n`);
console.log(`product.json: appended grok-ade@${version} builtInExtension`);