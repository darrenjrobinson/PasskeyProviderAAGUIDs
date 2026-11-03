#Requires -Version 7
<#
.SYNOPSIS
Refresh the cached AAGUID lists in data/ from the PassKey Developer Community list.

.DESCRIPTION
Downloads aaguid.json and combined_aaguid.json from passkeydeveloper/passkey-authenticator-aaguids,
merges in data/additional_aaguids.json (AAGUIDs not in the community list, e.g. Microsoft Authenticator)
and writes data/aaguid.json and data/combined_aaguid.json. The sample output tables in Readme.MD are
regenerated, and if the cached lists changed the module patch version is bumped.

Everything is validated before any file is written. If upstream data is empty, malformed, contains invalid
AAGUIDs or names, or would remove more than 10% of the cached entries, the script throws and changes nothing.

When run in GitHub Actions, 'changed' (true/false) and 'version' are written to $GITHUB_OUTPUT.

.PARAMETER Root
Repository root containing the manifest, Readme.MD and data folder. Defaults to the parent of this script's folder.

.PARAMETER UpstreamBaseUri
Base URI (or local folder, used by the tests) that aaguid.json and combined_aaguid.json are read from.

.PARAMETER NoVersionBump
Don't bump ModuleVersion in the manifest even if the cached lists changed.

.EXAMPLE
PS> ./build/Update-AAGUIDCache.ps1
#>
[CmdletBinding()]
param (
    [string]$Root = (Split-Path -Path $PSScriptRoot -Parent),
    [string]$UpstreamBaseUri = 'https://raw.githubusercontent.com/passkeydeveloper/passkey-authenticator-aaguids/refs/heads/main',
    [switch]$NoVersionBump
)

$ErrorActionPreference = 'Stop'
if ($PSStyle) { $PSStyle.OutputRendering = 'PlainText' }

$dataPath = Join-Path $Root 'data'
$manifestPath = Join-Path $Root 'PasskeyProviderAAGUIDs.psd1'
$readmePath = Join-Path $Root 'Readme.MD'
$utf8NoBom = [Text.UTF8Encoding]::new($false)
$guidPattern = '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z'
$maxRemovedRatio = 0.1

function Assert-AAGUIDEntry {
    param ([string]$AAGUID, $Name, [string]$Source)

    if ($AAGUID -cnotmatch $guidPattern) {
        throw "$($Source): '$AAGUID' is not a valid lowercase AAGUID."
    }
    if ($Name -isnot [string] -or [string]::IsNullOrWhiteSpace($Name)) {
        throw "$($Source): AAGUID $AAGUID has an empty or missing name."
    }
    if ($Name -match '[\p{Cc}�]') {
        throw "$($Source): AAGUID $AAGUID name '$Name' contains control or replacement characters."
    }
}

function Get-UpstreamJson {
    param ([string]$FileName)

    if (Test-Path -Path $UpstreamBaseUri -PathType Container) {
        $content = Get-Content -Path (Join-Path $UpstreamBaseUri $FileName) -Raw -Encoding utf8
    }
    else {
        $content = (Invoke-WebRequest -Method Get -Uri "$UpstreamBaseUri/$FileName" -TimeoutSec 120).Content
    }
    if ([string]::IsNullOrWhiteSpace($content)) {
        throw "Upstream $FileName is empty."
    }

    try {
        # ConvertFrom-Json keeps only the last of repeated keys, so read the raw keys with JsonDocument first
        $document = [System.Text.Json.JsonDocument]::Parse($content)
        try {
            $isObject = $document.RootElement.ValueKind -eq [System.Text.Json.JsonValueKind]::Object
            $keys = if ($isObject) { @($document.RootElement.EnumerateObject() | ForEach-Object Name) } else { @() }
        }
        finally {
            $document.Dispose()
        }
        $result = ConvertFrom-Json -InputObject $content -NoEnumerate
    }
    catch {
        throw "Upstream $FileName is not valid JSON: $($_.Exception.Message)"
    }
    if (-not $isObject -or $result -isnot [PSCustomObject]) {
        throw "Upstream $FileName is not a JSON object keyed by AAGUID."
    }

    $duplicates = @($keys | Group-Object | Where-Object Count -gt 1)
    if ($duplicates.Count -gt 0) {
        throw "Upstream $($FileName): duplicate AAGUIDs $($duplicates.Name -join ', ')."
    }
    return $result
}

function Get-AAGUIDList {
    param ([string]$FileName, [object[]]$Additional)

    $result = Get-UpstreamJson -FileName $FileName
    $list = @(foreach ($property in $result.PSObject.Properties) {
            Assert-AAGUIDEntry -AAGUID $property.Name -Name $property.Value.name -Source $FileName
            [PSCustomObject]@{
                AAGUID = $property.Name
                Name   = $property.Value.name
            }
        })
    if ($list.Count -eq 0) {
        throw "Upstream $FileName contains no entries."
    }
    $list += @($Additional | Where-Object { $list.AAGUID -notcontains $_.AAGUID })

    $duplicates = @($list | Group-Object -Property AAGUID | Where-Object Count -gt 1)
    if ($duplicates.Count -gt 0) {
        throw "$($FileName): duplicate AAGUIDs $($duplicates.Name -join ', ')."
    }

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

$additional = @(Get-Content -Path (Join-Path $dataPath 'additional_aaguids.json') -Raw -Encoding utf8 | ConvertFrom-Json)
foreach ($entry in $additional) {
    Assert-AAGUIDEntry -AAGUID $entry.AAGUID -Name $entry.Name -Source 'additional_aaguids.json'
}

$caches = @(
    @{ File = 'aaguid.json'; Marker = 'providers' }
    @{ File = 'combined_aaguid.json'; Marker = 'mds' }
)

# Fetch and validate everything before writing anything
foreach ($cache in $caches) {
    $cache.Path = Join-Path $dataPath $cache.File
    $cache.List = @(Get-AAGUIDList -FileName $cache.File -Additional $additional)
    $cache.Json = ConvertTo-CacheJson -List $cache.List

    $cache.ExistingJson = ''
    $cache.Existing = @()
    if (Test-Path $cache.Path) {
        $cache.ExistingJson = [IO.File]::ReadAllText($cache.Path).Replace("`r`n", "`n")
        $cache.Existing = @($cache.ExistingJson | ConvertFrom-Json)
    }

    $cache.Added = @($cache.List | Where-Object { $cache.Existing.AAGUID -notcontains $_.AAGUID })
    $cache.Removed = @($cache.Existing | Where-Object { $cache.List.AAGUID -notcontains $_.AAGUID })
    $cache.Renamed = @(foreach ($entry in $cache.List) {
            $old = $cache.Existing | Where-Object { $_.AAGUID -eq $entry.AAGUID } | Select-Object -First 1
            if ($old -and $old.Name -cne $entry.Name) { "$($entry.AAGUID): '$($old.Name)' -> '$($entry.Name)'" }
        })

    # Guard against a broken or truncated upstream file wiping out the cache
    if ($cache.Existing.Count -gt 0 -and $cache.Removed.Count -gt [Math]::Floor($cache.Existing.Count * $maxRemovedRatio)) {
        throw "Upstream $($cache.File) would remove $($cache.Removed.Count) of $($cache.Existing.Count) cached entries (limit $($maxRemovedRatio * 100)%). Refusing to update."
    }
}

$providers = $caches | Where-Object Marker -eq 'providers'
$combined = $caches | Where-Object Marker -eq 'mds'
$missing = @($providers.List | Where-Object { $combined.List.AAGUID -notcontains $_.AAGUID })
if ($missing.Count -gt 0) {
    throw "Provider AAGUIDs missing from combined_aaguid.json: $($missing.AAGUID -join ', ')."
}

$readme = [IO.File]::ReadAllText($readmePath)
$newline = if ($readme.Contains("`r`n")) { "`r`n" } else { "`n" }
$newReadme = $readme
foreach ($cache in $caches) {
    $start = "<!-- AAGUIDS:$($cache.Marker):start -->"
    $end = "<!-- AAGUIDS:$($cache.Marker):end -->"
    $pattern = "(?s)$([regex]::Escape($start)).*?$([regex]::Escape($end))"
    if ($newReadme -notmatch $pattern) {
        throw "Readme markers '$start' / '$end' not found."
    }
    $block = @($start, '```powershell', (ConvertTo-ReadmeTable -List $cache.List), '```', $end) -join "`n"
    $newReadme = [regex]::Replace($newReadme, $pattern, { $block.Replace("`n", $newline) })
}

# All checks passed, write the changes
$dataChanged = $false
foreach ($cache in $caches) {
    if ($cache.Json -cne $cache.ExistingJson) {
        $dataChanged = $true
        [IO.File]::WriteAllText($cache.Path, $cache.Json, $utf8NoBom)

        Write-Host "$($cache.File): $($cache.Existing.Count) -> $($cache.List.Count) entries ($($cache.Added.Count) added, $($cache.Removed.Count) removed, $($cache.Renamed.Count) renamed)"
        $cache.Added | ForEach-Object { Write-Host "  + $($_.AAGUID) $($_.Name)" }
        $cache.Removed | ForEach-Object { Write-Host "  - $($_.AAGUID) $($_.Name)" }
        $cache.Renamed | ForEach-Object { Write-Host "  ~ $_" }
    }
    else {
        Write-Host "$($cache.File): no changes ($($cache.List.Count) entries)"
    }
}

$readmeChanged = $newReadme -cne $readme
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
