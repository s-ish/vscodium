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
\t\tdescription: localize('gettingStarted.grokAgent.description', "Chat with Grok about your codebase"),
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

const remoteEntryEnd =
  /(\t\{\n\t\tid: 'topLevelRemoteOpen',[\s\S]*?\n\t\},)\n(\];)/;

if (!remoteEntryEnd.test(content)) {
  console.error('inject-grok-welcome: could not find topLevelRemoteOpen anchor');
  process.exit(1);
}

content = content.replace(remoteEntryEnd, `$1\n${grokEntries}\n$2`);
writeFileSync(file, content);
console.log('gettingStartedContent.ts: injected Grok ADE start entries');