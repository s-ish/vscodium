#!/usr/bin/env node
/**
 * Inject Grok ADE start entries into gettingStartedContent.ts after VSCodium patches.
 */
import { readFileSync, writeFileSync } from 'node:fs';

const file = 'src/vs/workbench/contrib/welcomeGettingStarted/common/gettingStartedContent.ts';
let content = readFileSync(file, 'utf8');

if (content.includes("topLevelGrokAgent")) {
  console.log('gettingStartedContent.ts: Grok start entries already present');
  process.exit(0);
}

const grokEntries = `\t{
\t\tid: 'topLevelGrokAgent',
\t\ttitle: localize('gettingStarted.grokAgent.title', "Open Grok Agent"),
\t\tdescription: localize('gettingStarted.grokAgent.description', "Chat with Grok in the secondary side bar"),
\t\twhen: '!isWeb',
\t\ticon: Codicon.sparkle,
\t\tcontent: {
\t\t\ttype: 'startEntry',
\t\t\tcommand: 'command:grok-ade.focusPanel',
\t\t}
\t},
\t{
\t\tid: 'topLevelGrokSetup',
\t\ttitle: localize('gettingStarted.grokSetup.title', "Set up Grok ADE"),
\t\tdescription: localize('gettingStarted.grokSetup.description', "Install Grok CLI and sign in"),
\t\twhen: '!isWeb',
\t\ticon: Codicon.zap,
\t\tcontent: {
\t\t\ttype: 'startEntry',
\t\t\tcommand: 'command:grok-ade.welcome.openWalkthrough',
\t\t}
\t},`;

const EOL = content.includes('\r\n') ? '\r\n' : '\n';

const entryBlock = (id) =>
  new RegExp(
    `(\\t\\{\\r?\\n\\t\\tid: '${id}',[\\s\\S]*?\\r?\\n\\t\\},)\\r?\\n(\\];)`,
  );

const anchors = [
  'topLevelRemoteOpen',
  'topLevelGitOpen',
  'topLevelGitClone',
  'topLevelOpenFolder',
  'topLevelOpenFile',
];

let injected = false;
for (const id of anchors) {
  const pattern = entryBlock(id);
  if (pattern.test(content)) {
    content = content.replace(pattern, `$1${EOL}${grokEntries}${EOL}$2`);
    injected = true;
    console.log(`gettingStartedContent.ts: injected Grok ADE start entries after ${id}`);
    break;
  }
}

if (!injected) {
  const fallback = /(export const startEntries: GettingStartedStartEntryContent = \[[\s\S]*?)(\r?\n];)/;
  if (fallback.test(content)) {
    content = content.replace(fallback, `$1${EOL}${grokEntries}$2`);
    injected = true;
    console.log('gettingStartedContent.ts: injected Grok ADE start entries before startEntries close');
  }
}

if (!injected) {
  console.error('inject-grok-welcome: could not find a startEntries injection anchor');
  process.exit(1);
}

writeFileSync(file, content);