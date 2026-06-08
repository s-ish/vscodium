#!/usr/bin/env bash
# shellcheck disable=SC2154
# Grok ADE string replacements in vscode tree — sourced near end of prepare_vscode.sh

replace 's|Microsoft Corporation|Grok ADE|' package.json
replace 's|Microsoft Corporation|Grok ADE|' build/lib/electron.ts
replace 's|([0-9]) Microsoft|\1 Grok ADE|' build/lib/electron.ts

cp resources/server/manifest.json{,.bak}
setpath "resources/server/manifest" "name" "Grok ADE"
setpath "resources/server/manifest" "short_name" "Grok ADE"

if [[ "${OS_NAME}" == "linux" ]]; then
  sed -i "s/code-oss/grok-ade/" resources/linux/debian/postinst.template

  sed -i 's|Visual Studio Code|Grok ADE|g' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/grok-ade/grok-ade#download|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/home/home-screenshot-linux-lg.png|https://raw.githubusercontent.com/grok-ade/grok-ade/main/fork/vscodium/icons/grok-ade/grok_ade.svg|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com|https://github.com/grok-ade/grok-ade|g' resources/linux/code.appdata.xml

  sed -i 's|Microsoft Corporation <vscode-linux@microsoft.com>|Grok ADE https://github.com/grok-ade/grok-ade|' resources/linux/debian/control.template
  sed -i 's|Visual Studio Code|Grok ADE|g' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/grok-ade/grok-ade#download|' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com|https://github.com/grok-ade/grok-ade|g' resources/linux/debian/control.template

  sed -i 's|Microsoft Corporation|Grok ADE|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code Team <vscode-linux@microsoft.com>|Grok ADE https://github.com/grok-ade/grok-ade|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code|Grok ADE|g' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/grok-ade/grok-ade#download|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com|https://github.com/grok-ade/grok-ade|g' resources/linux/rpm/code.spec.template
elif [[ "${OS_NAME}" == "windows" ]]; then
  sed -i 's|https://code.visualstudio.com|https://github.com/grok-ade/grok-ade|g' build/win32/code.iss
  sed -i 's|Microsoft Corporation|Grok ADE|g' build/win32/code.iss
fi