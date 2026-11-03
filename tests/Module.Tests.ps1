BeforeAll {
    . (Join-Path $PSScriptRoot 'TestHelpers.ps1')
    $moduleRoot = Get-TestModuleRoot
    $manifestPath = Join-Path $moduleRoot 'PasskeyProviderAAGUIDs.psd1'
    $manifest = Import-PowerShellDataFile -Path $manifestPath
    Get-Module PasskeyProviderAAGUIDs | Remove-Module -Force
    $module = Import-Module $manifestPath -Force -PassThru
}

AfterAll {
    $module | Remove-Module -Force
}

Describe 'Module manifest' {
    It 'passes Test-ModuleManifest' {
        { Test-ModuleManifest -Path $manifestPath -ErrorAction Stop } | Should -Not -Throw
    }

    It 'loads from the folder under test' {
        $module.ModuleBase | Should -Be $moduleRoot
    }

    # Exact case matters on Linux and for the PowerShell Gallery package
    It 'has RootModule and every FileList entry on disk with the exact case' {
        $files = Get-ChildItem -Path $moduleRoot -Recurse -File | ForEach-Object {
            $_.FullName.Substring($moduleRoot.Length).TrimStart('\', '/').Replace('\', '/')
        }
        foreach ($file in @($manifest.RootModule) + @($manifest.FileList)) {
            $files -ccontains $file.Replace('\', '/') | Should -BeTrue -Because "'$file' must exist with this exact case"
        }
    }

    It 'exports only Get-AAGUIDs' {
        (@($module.ExportedFunctions.Keys) -join ',') | Should -Be 'Get-AAGUIDs'
    }

    It 'has no stale Authenticode signature block' {
        foreach ($file in 'PasskeyProviderAAGUIDs.psd1', 'PasskeyProviderAAGUIDs.psm1') {
            Get-Content -Path (Join-Path $moduleRoot $file) -Raw | Should -Not -Match '# SIG # Begin signature block'
        }
    }
}

Describe 'Get-AAGUIDs <Label>' -ForEach @(
    @{ Label = '-cache'; Parameters = @{ cache = $true }; File = 'aaguid.json' }
    @{ Label = '-MDS -cache'; Parameters = @{ MDS = $true; cache = $true }; File = 'combined_aaguid.json' }
) {
    BeforeAll {
        $results = @(Get-AAGUIDs @Parameters)
        $expected = Read-JsonFile -Path (Join-Path $moduleRoot "data/$File")
    }

    It 'returns one object per cached entry' {
        $results.Count | Should -Be $expected.Count
        foreach ($result in $results) {
            $result.AAGUID | Should -Not -BeNullOrEmpty
            $result.Name | Should -Not -BeNullOrEmpty
        }
    }

    It 'returns the same AAGUIDs as the data file' {
        Compare-Object -ReferenceObject $expected.AAGUID -DifferenceObject $results.AAGUID | Should -BeNullOrEmpty
    }

    # Case-insensitive because Windows PowerShell 5.1's sort isn't stable for names differing only in case
    It 'returns entries sorted by Name' {
        ($results.Name -join '|') | Should -Be ((($results | Sort-Object -Property Name).Name) -join '|')
    }

    # Regression test: in Windows PowerShell 5.1 the cached list was emitted as a single array object
    It 'enumerates entries individually in the pipeline' {
        @(Get-AAGUIDs @Parameters | Where-Object { $_.Name -like '*hello*' }).Count | Should -BeGreaterThan 1
        @(Get-AAGUIDs @Parameters | Select-Object -First 1).Count | Should -Be 1
    }

    It 'decodes non-ASCII names correctly' {
        ($results | Where-Object AAGUID -eq '891494da-2c90-4d31-a9cd-4eab0aed1309').Name | Should -BeExactly "S$([char]0x00E9)same"
    }
}

Describe 'Get-AAGUIDs live lists match the cache' -Tag 'Live' -ForEach @(
    @{ Label = 'providers'; Live = @{}; Cache = @{ cache = $true } }
    @{ Label = 'MDS'; Live = @{ MDS = $true }; Cache = @{ MDS = $true; cache = $true } }
) {
    It 'returns the same <Label> AAGUIDs and names live as cached' {
        $live = @(Get-AAGUIDs @Live)
        $cached = @(Get-AAGUIDs @Cache)
        $live.Count | Should -BeGreaterThan 0
        Compare-Object -ReferenceObject $cached -DifferenceObject $live -Property AAGUID, Name | Should -BeNullOrEmpty
    }
}
