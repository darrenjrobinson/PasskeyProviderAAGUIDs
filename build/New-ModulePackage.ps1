<#
.SYNOPSIS
Stage the publishable module folder.

.DESCRIPTION
Copies the files listed in the manifest's FileList, plus LICENSE and Readme.MD, into
<Destination>/PasskeyProviderAAGUIDs and returns that folder's path. The folder can be tested with
tests/Invoke-Tests.ps1 -Path <folder> and published with Publish-PSResource -Path <folder>.

.PARAMETER Destination
Folder to stage the module under. Defaults to a folder in the system temp directory.

.EXAMPLE
PS> $package = ./build/New-ModulePackage.ps1
#>
[CmdletBinding()]
param (
    [string]$Destination = (Join-Path ([IO.Path]::GetTempPath()) 'PasskeyProviderAAGUIDs-package')
)

$ErrorActionPreference = 'Stop'

$moduleName = 'PasskeyProviderAAGUIDs'
$root = Split-Path -Path $PSScriptRoot -Parent
$manifest = Import-PowerShellDataFile -Path (Join-Path $root "$moduleName.psd1")
$staging = Join-Path $Destination $moduleName

if (Test-Path $staging) {
    Remove-Item -Path $staging -Recurse -Force
}

foreach ($file in @($manifest.FileList) + 'LICENSE', 'Readme.MD') {
    $target = Join-Path $staging $file
    New-Item -ItemType Directory -Path (Split-Path $target -Parent) -Force | Out-Null
    Copy-Item -Path (Join-Path $root $file) -Destination $target
}

return $staging
