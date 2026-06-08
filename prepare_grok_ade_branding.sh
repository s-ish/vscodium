#!/usr/bin/env bash
# shellcheck disable=SC2154
# Grok ADE product.json branding — sourced from prepare_vscode.sh when GROK_ADE_BUILD=yes

setpath "product" "licenseUrl" "https://github.com/grok-ade/grok-ade/blob/main/LICENSE"
setpath "product" "reportIssueUrl" "https://github.com/grok-ade/grok-ade/issues/new"
setpath "product" "documentationUrl" "https://github.com/grok-ade/grok-ade#readme"
setpath "product" "welcomePageUrl" "https://github.com/grok-ade/grok-ade#quick-start"

if [[ "${DISABLE_UPDATE}" != "yes" ]]; then
  setpath "product" "updateUrl" "https://raw.githubusercontent.com/grok-ade/versions/refs/heads/master"
  setpath "product" "downloadUrl" "https://github.com/grok-ade/grok-ade/releases"
fi

setpath "product" "nameShort" "Grok ADE"
setpath "product" "nameLong" "Grok Agentic Development Environment"
setpath "product" "applicationName" "grok-ade"
setpath "product" "dataFolderName" ".grok-ade"
setpath "product" "linuxIconName" "grok-ade"
setpath "product" "quality" "stable"
setpath "product" "urlProtocol" "grok-ade"
setpath "product" "serverApplicationName" "grok-ade-server"
setpath "product" "serverDataFolderName" ".grok-ade-server"
setpath "product" "darwinBundleIdentifier" "com.grok-ade.app"
setpath "product" "win32AppUserModelId" "Grok.GrokADE"
setpath "product" "win32DirName" "Grok ADE"
setpath "product" "win32MutexName" "grokade"
setpath "product" "win32NameVersion" "Grok ADE"
setpath "product" "win32RegValueName" "GrokADE"
setpath "product" "win32ShellNameShort" "Grok ADE"
setpath "product" "win32AppId" "{{8F3A2B1C-4D5E-6F70-8A9B-0C1D2E3F4A5B}"
setpath "product" "win32x64AppId" "{{9E4B3C2D-5E6F-7081-9BAC-1D2E3F4A5B6C}"
setpath "product" "win32arm64AppId" "{{A0C5D4E3-6F70-8192-ACBD-2E3F4A5B6C7D}"
setpath "product" "win32UserAppId" "{{B1D6E5F4-7081-92A3-BCDE-3F4A5B6C7D8E}"
setpath "product" "win32x64UserAppId" "{{C2E7F608-8192-A3B4-CDEF-4A5B6C7D8E9F}"
setpath "product" "win32arm64UserAppId" "{{D3F80919-92A3-B4C5-DEF0-5B6C7D8E9F0A}"
setpath "product" "tunnelApplicationName" "grok-ade-tunnel"
setpath "product" "win32TunnelServiceMutex" "grokade-tunnelservice"
setpath "product" "win32TunnelMutex" "grokade-tunnel"
setpath "product" "win32ContextMenu.x64.clsid" "E4A91B2C-3D5F-4E6A-9B0C-1D2E3F4A5B6C"
setpath "product" "win32ContextMenu.arm64.clsid" "F5B02C3D-4E60-5F7B-AC1D-2E3F4A5B6C7D"