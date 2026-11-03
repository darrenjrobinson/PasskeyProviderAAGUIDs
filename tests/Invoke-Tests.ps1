<#
.SYNOPSIS
Run the Pester tests for the module, its cached data and the build script.

.DESCRIPTION
Requires Pester 5.5 or later:
    Install-Module Pester -MinimumVersion 5.5 -Scope CurrentUser -Force -SkipPublisherCheck

Exits with code 1 if any test fails, so it can gate CI steps.

.PARAMETER Path
A staged module folder (from build/New-ModulePackage.ps1) to test instead of the repository.
Only the Data and Module suites run against a staged folder.

.PARAMETER Suite
The suites to run: Data, Module and/or Build. Defaults to all of them (Data and Module with -Path).
The Build suite needs PowerShell 7 and is skipped in Windows PowerShell 5.1.

.PARAMETER IncludeLive
Also run the tests tagged Live, which compare the cached lists with the live upstream lists (needs network access).

.PARAMETER OutputPath
Write NUnit XML test results to this file.

.EXAMPLE
PS> ./tests/Invoke-Tests.ps1
PS> ./tests/Invoke-Tests.ps1 -IncludeLive
PS> ./tests/Invoke-Tests.ps1 -Path (./build/New-ModulePackage.ps1)
#>
[CmdletBinding()]
param (
    [string]$Path,
    [ValidateSet('Data', 'Module', 'Build')]
    [string[]]$Suite,
    [switch]$IncludeLive,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'

$pester = Get-Module -Name Pester -ListAvailable | Where-Object Version -ge '5.5.0' | Sort-Object Version -Descending | Select-Object -First 1
if (-not $pester) {
    throw 'Pester 5.5 or later is required. Install it with: Install-Module Pester -MinimumVersion 5.5 -Scope CurrentUser -Force -SkipPublisherCheck'
}
Import-Module $pester.Path -Force

if (-not $Suite) {
    $Suite = if ($Path) { 'Data', 'Module' } else { 'Data', 'Module', 'Build' }
}
if ($Path -and $Suite -contains 'Build') {
    Write-Warning 'The Build suite always tests the repository, not the staged folder given by -Path.'
}
if ($PSVersionTable.PSEdition -eq 'Desktop' -and $Suite -contains 'Build') {
    Write-Warning 'Skipping the Build suite, which needs PowerShell 7.'
    $Suite = @($Suite | Where-Object { $_ -ne 'Build' })
}

$config = New-PesterConfiguration
$config.Run.Path = @($Suite | ForEach-Object { Join-Path $PSScriptRoot "$_.Tests.ps1" })
$config.Run.PassThru = $true
$config.Output.Verbosity = 'Detailed'
if (-not $IncludeLive) {
    $config.Filter.ExcludeTag = 'Live'
}
if ($OutputPath) {
    $config.TestResult.Enabled = $true
    $config.TestResult.OutputFormat = 'NUnitXml'
    $config.TestResult.OutputPath = $OutputPath
}

$previousModulePath = $env:AAGUID_MODULE_PATH
try {
    $env:AAGUID_MODULE_PATH = if ($Path) { (Resolve-Path -Path $Path).Path } else { $null }
    $result = Invoke-Pester -Configuration $config
}
finally {
    $env:AAGUID_MODULE_PATH = $previousModulePath
}

if ($result.Result -ne 'Passed') {
    exit 1
}
