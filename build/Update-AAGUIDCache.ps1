#Requires -Version 7
<#
.SYNOPSIS
Refresh the cached AAGUID lists in data/ from the PassKey Developer Community list.

.DESCRIPTION
Downloads aaguid.json and combined_aaguid.json from passkeydeveloper/passkey-authenticator-aaguids,
merges in data/additional_aaguids.json (AAGUIDs not in the community list, e.g. Microsoft Authenticator)
and writes data/aaguid.json and data/combined_aaguid.json. The sample output tables in Readme.MD are
regenerated, and if the cached lists changed the module patch version is bumped.

When run in GitHub Actions, 'changed' (true/false) and 'version' are written to $GITHUB_OUTPUT.

.PARAMETER NoVersionBump
Don't bump ModuleVersion in the manifest even if the cached lists changed.

.EXAMPLE
PS> ./build/Update-AAGUIDCache.ps1
#>
[CmdletBinding()]
param (
    [switch]$NoVersionBump
)

$ErrorActionPreference = 'Stop'
if ($PSStyle) { $PSStyle.OutputRendering = 'PlainText' }

$root = Split-Path -Path $PSScriptRoot -Parent
$dataPath = Join-Path $root 'data'
$manifestPath = Join-Path $root 'PasskeyProviderAAGUIDs.psd1'
$readmePath = Join-Path $root 'Readme.MD'
$baseUri = 'https://raw.githubusercontent.com/passkeydeveloper/passkey-authenticator-aaguids/refs/heads/main'
$utf8NoBom = [Text.UTF8Encoding]::new($false)

$additional = Get-Content -Path (Join-Path $dataPath 'additional_aaguids.json') -Raw | ConvertFrom-Json

function Get-UpstreamAAGUIDs {
    param ([string]$FileName)

    $result = Invoke-RestMethod -Method Get -Uri "$baseUri/$FileName" -TimeoutSec 120
    $list = @(foreach ($property in $result.PSObject.Properties) {
            [PSCustomObject]@{
                AAGUID = $property.Name
                Name   = [string]$property.Value.name
            }
        })
    $list += @($additional | Where-Object { $list.AAGUID -notcontains $_.AAGUID })

    return $list | Sort-Object -Property Name, AAGUID -Culture 'en-US'
}

function ConvertTo-CacheJson {
    param ([object[]]$List)

    return (ConvertTo-Json -InputObject @($List) -Depth 3).Replace("`r`n", "`n") + "`n"
}

function ConvertTo-ReadmeTable {
    param ([object[]]$List)

    $table = $List | Format-Table -Property AAGUID, Name -AutoSize | Out-String -Width 4096
    $lines = $table.Replace("`r`n", "`n").Trim("`n").Split("`n") | ForEach-Object { $_.TrimEnd() }
    return ($lines -join "`n")
}

$caches = @(
    @{ File = 'aaguid.json'; Marker = 'providers' }
    @{ File = 'combined_aaguid.json'; Marker = 'mds' }
)

$dataChanged = $false
$readme = [IO.File]::ReadAllText($readmePath)
$newline = if ($readme.Contains("`r`n")) { "`r`n" } else { "`n" }
$newReadme = $readme

foreach ($cache in $caches) {
    $cachePath = Join-Path $dataPath $cache.File
    $list = Get-UpstreamAAGUIDs -FileName $cache.File

    $existing = @()
    $existingJson = ''
    if (Test-Path $cachePath) {
        $existingJson = [IO.File]::ReadAllText($cachePath).Replace("`r`n", "`n")
        $existing = @($existingJson | ConvertFrom-Json)
    }

    # Guard against a broken or truncated upstream file wiping out the cache
    if ($list.Count -lt [Math]::Max(10, [int]($existing.Count / 2))) {
        throw "Upstream $($cache.File) returned $($list.Count) entries (cache has $($existing.Count)). Refusing to update."
    }

    $json = ConvertTo-CacheJson -List $list
    if ($json -ne $existingJson) {
        $dataChanged = $true
        [IO.File]::WriteAllText($cachePath, $json, $utf8NoBom)

        $added = @($list | Where-Object { $existing.AAGUID -notcontains $_.AAGUID })
        $removed = @($existing | Where-Object { $list.AAGUID -notcontains $_.AAGUID })
        $renamed = @($list | ForEach-Object {
                $entry = $_
                $old = $existing | Where-Object { $_.AAGUID -eq $entry.AAGUID } | Select-Object -First 1
                if ($old -and $old.Name -cne $entry.Name) { "$($entry.AAGUID): '$($old.Name)' -> '$($entry.Name)'" }
            })

        Write-Host "$($cache.File): $($existing.Count) -> $($list.Count) entries ($($added.Count) added, $($removed.Count) removed, $($renamed.Count) renamed)"
        $added | ForEach-Object { Write-Host "  + $($_.AAGUID) $($_.Name)" }
        $removed | ForEach-Object { Write-Host "  - $($_.AAGUID) $($_.Name)" }
        $renamed | ForEach-Object { Write-Host "  ~ $_" }
    }
    else {
        Write-Host "$($cache.File): no changes ($($list.Count) entries)"
    }

    $start = "<!-- AAGUIDS:$($cache.Marker):start -->"
    $end = "<!-- AAGUIDS:$($cache.Marker):end -->"
    $pattern = "(?s)$([regex]::Escape($start)).*?$([regex]::Escape($end))"
    if ($newReadme -notmatch $pattern) {
        throw "Readme markers '$start' / '$end' not found."
    }
    $block = @($start, '```powershell', (ConvertTo-ReadmeTable -List $list), '```', $end) -join "`n"
    $newReadme = [regex]::Replace($newReadme, $pattern, { $block.Replace("`n", $newline) })
}

$readmeChanged = $newReadme -ne $readme
if ($readmeChanged) {
    [IO.File]::WriteAllText($readmePath, $newReadme, $utf8NoBom)
    Write-Host 'Readme.MD sample output updated'
}

$manifest = [IO.File]::ReadAllText($manifestPath)
if ($dataChanged -and -not $NoVersionBump) {
    $manifest = [regex]::Replace($manifest, "(ModuleVersion\s*=\s*')(\d+)\.(\d+)\.(\d+)(')", {
            param ($m)
            "$($m.Groups[1].Value)$($m.Groups[2].Value).$($m.Groups[3].Value).$([int]$m.Groups[4].Value + 1)$($m.Groups[5].Value)"
        })
    [IO.File]::WriteAllText($manifestPath, $manifest, $utf8NoBom)
}
$version = [regex]::Match($manifest, "ModuleVersion\s*=\s*'([^']+)'").Groups[1].Value

$changed = $dataChanged -or $readmeChanged
Write-Host "Changed: $changed  Version: $version"

if ($env:GITHUB_OUTPUT) {
    "changed=$($changed.ToString().ToLower())" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
    "version=$version" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
}
