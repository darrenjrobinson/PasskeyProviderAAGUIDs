BeforeAll {
    . (Join-Path $PSScriptRoot 'TestHelpers.ps1')
    $moduleRoot = Get-TestModuleRoot
    $additional = Read-JsonFile -Path (Join-Path $moduleRoot 'data/additional_aaguids.json')
}

# Minimum entry counts, set a little below the counts at the time of writing (69 and 410) so an empty or
# truncated refresh fails. Raise them as the upstream lists grow.
Describe 'Cached AAGUID data <File>' -ForEach @(
    @{ File = 'aaguid.json'; MinimumCount = 60 }
    @{ File = 'combined_aaguid.json'; MinimumCount = 350 }
) {
    BeforeAll {
        $path = Join-Path $moduleRoot "data/$File"
        $bytes = [IO.File]::ReadAllBytes($path)
        $text = [Text.UTF8Encoding]::new($false, $true).GetString($bytes)
        $entries = Read-JsonFile -Path $path
    }

    It 'is valid UTF-8 without a BOM' {
        $bytes.Count | Should -BeGreaterThan 3
        ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) | Should -BeFalse
    }

    It 'uses LF line endings and ends with a newline' {
        $text | Should -Not -Match "`r"
        $text | Should -Match "`n$"
    }

    It 'is a JSON array' {
        $text.TrimStart() | Should -Match '^\['
    }

    It 'has at least <MinimumCount> entries' {
        $entries.Count | Should -BeGreaterOrEqual $MinimumCount
    }

    It 'has only AAGUID and Name properties on every entry' {
        $bad = @($entries | Where-Object { (@($_.PSObject.Properties.Name) -join ',') -cne 'AAGUID,Name' })
        $bad.Count | Should -Be 0 -Because "entries with unexpected properties: $($bad | ConvertTo-Json -Compress)"
    }

    It 'has valid lowercase AAGUIDs' {
        $bad = @($entries | Where-Object { $_.AAGUID -cnotmatch $GuidPattern })
        $bad.Count | Should -Be 0 -Because "invalid AAGUIDs: $($bad.AAGUID -join ', ')"
    }

    It 'has non-empty names without control or replacement characters' {
        $bad = @($entries | Where-Object { $_.Name -isnot [string] -or [string]::IsNullOrWhiteSpace($_.Name) -or $_.Name -match '[\p{Cc}�]' })
        $bad.Count | Should -Be 0 -Because "invalid names for: $($bad.AAGUID -join ', ')"
    }

    It 'has no duplicate AAGUIDs' {
        $duplicates = @($entries | Group-Object -Property AAGUID | Where-Object Count -gt 1)
        $duplicates.Count | Should -Be 0 -Because "duplicates: $($duplicates.Name -join ', ')"
    }

    It 'includes the additional AAGUIDs' {
        foreach ($entry in $additional) {
            $entries.AAGUID | Should -Contain $entry.AAGUID
        }
    }

    # Sorting is culture-sensitive and Windows PowerShell 5.1 (.NET Framework) orders some names differently
    It 'is sorted the way the build script sorts it' -Skip:($PSVersionTable.PSEdition -eq 'Desktop') {
        $sorted = $entries | Sort-Object -Property Name, AAGUID -Culture 'en-US'
        ($entries.AAGUID -join ',') | Should -BeExactly ($sorted.AAGUID -join ',')
    }
}

Describe 'Cached AAGUID data consistency' {
    It 'includes every passkey provider in the combined MDS list' {
        $providers = Read-JsonFile -Path (Join-Path $moduleRoot 'data/aaguid.json')
        $combined = Read-JsonFile -Path (Join-Path $moduleRoot 'data/combined_aaguid.json')
        $missing = @($providers | Where-Object { $combined.AAGUID -notcontains $_.AAGUID })
        $missing.Count | Should -Be 0 -Because "missing from combined: $($missing.AAGUID -join ', ')"
    }
}
