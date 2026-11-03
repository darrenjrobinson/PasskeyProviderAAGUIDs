#Requires -Version 7
# Runs build/Update-AAGUIDCache.ps1 against generated upstream files in TestDrive: (no network access)
BeforeAll {
    $repoRoot = (Resolve-Path -Path (Join-Path $PSScriptRoot '..')).Path
    $buildScript = Join-Path $repoRoot 'build/Update-AAGUIDCache.ps1'
    $sesame = "S$([char]0x00E9)same"
    $guidLine = '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12} '

    function New-TestGuid {
        param ([int]$Seed)
        return '{0:x8}-0000-4000-8000-{1:x12}' -f $Seed, $Seed
    }

    # 20 providers plus Sésame, and a combined list of those plus 30 security keys
    function New-UpstreamData {
        $providers = [ordered]@{}
        foreach ($i in 1..20) { $providers[(New-TestGuid $i)] = @{ name = "Provider $i" } }
        $providers['891494da-2c90-4d31-a9cd-4eab0aed1309'] = @{ name = $sesame }

        $combined = [ordered]@{}
        foreach ($key in $providers.Keys) { $combined[$key] = $providers[$key] }
        foreach ($i in 1001..1030) { $combined[(New-TestGuid $i)] = @{ name = "Security Key $i" } }

        return @{ Providers = $providers; Combined = $combined }
    }

    function Save-Upstream {
        param ($Data, [string]$ProvidersJson, [string]$CombinedJson)

        $path = Join-Path $TestDrive "upstream-$([guid]::NewGuid())"
        New-Item -ItemType Directory -Path $path | Out-Null
        if (-not $ProvidersJson) { $ProvidersJson = $Data.Providers | ConvertTo-Json -Depth 3 }
        if (-not $CombinedJson) { $CombinedJson = $Data.Combined | ConvertTo-Json -Depth 3 }
        Set-Content -Path (Join-Path $path 'aaguid.json') -Value $ProvidersJson -Encoding utf8NoBOM -NoNewline
        Set-Content -Path (Join-Path $path 'combined_aaguid.json') -Value $CombinedJson -Encoding utf8NoBOM -NoNewline
        return $path
    }

    function New-TestRepo {
        $path = Join-Path $TestDrive "repo-$([guid]::NewGuid())"
        New-Item -ItemType Directory -Path (Join-Path $path 'data') -Force | Out-Null
        Copy-Item -Path (Join-Path $repoRoot 'PasskeyProviderAAGUIDs.psd1'), (Join-Path $repoRoot 'Readme.MD') -Destination $path
        Copy-Item -Path (Join-Path $repoRoot 'data/additional_aaguids.json') -Destination (Join-Path $path 'data')
        return $path
    }

    function Invoke-Build {
        param ([string]$Repo, [string]$Upstream, [switch]$NoVersionBump)

        $env:GITHUB_OUTPUT = Join-Path $TestDrive "output-$([guid]::NewGuid()).txt"
        try {
            & $buildScript -Root $Repo -UpstreamBaseUri $Upstream -NoVersionBump:$NoVersionBump 6>$null | Out-Null
            $output = @{}
            foreach ($line in Get-Content -Path $env:GITHUB_OUTPUT) {
                $key, $value = $line -split '=', 2
                $output[$key] = $value
            }
            return $output
        }
        finally {
            Remove-Item -Path Env:GITHUB_OUTPUT
        }
    }

    function Get-RepoState {
        param ([string]$Repo)
        return (Get-ChildItem -Path $Repo -Recurse -File | Sort-Object FullName | ForEach-Object {
                "$($_.FullName.Substring($Repo.Length))=$((Get-FileHash -Path $_.FullName).Hash)"
            }) -join ';'
    }

    function Get-ManifestVersion {
        param ([string]$Repo)
        return (Import-PowerShellDataFile -Path (Join-Path $Repo 'PasskeyProviderAAGUIDs.psd1')).ModuleVersion
    }

    function Read-Data {
        param ([string]$Repo, [string]$File)
        return @(Get-Content -Path (Join-Path $Repo "data/$File") -Raw | ConvertFrom-Json)
    }

    $additional = @(Get-Content -Path (Join-Path $repoRoot 'data/additional_aaguids.json') -Raw | ConvertFrom-Json)
}

Describe 'Update-AAGUIDCache.ps1' {
    Context 'with valid upstream data' {
        BeforeAll {
            $repo = New-TestRepo
            $upstream = Save-Upstream -Data (New-UpstreamData)
            $startVersion = [version](Get-ManifestVersion $repo)
            $readmeHadCrLf = (Get-Content -Path (Join-Path $repo 'Readme.MD') -Raw).Contains("`r`n")
            $first = Invoke-Build -Repo $repo -Upstream $upstream
        }

        It 'reports a change and bumps the patch version' {
            $expected = '{0}.{1}.{2}' -f $startVersion.Major, $startVersion.Minor, ($startVersion.Build + 1)
            $first.changed | Should -Be 'true'
            $first.version | Should -Be $expected
            Get-ManifestVersion $repo | Should -Be $expected
        }

        It 'writes the provider list with the additional AAGUIDs' {
            $providers = Read-Data -Repo $repo -File 'aaguid.json'
            $providers.Count | Should -Be (21 + $additional.Count)
            foreach ($entry in $additional) { $providers.AAGUID | Should -Contain $entry.AAGUID }
            ($providers | Where-Object AAGUID -eq '891494da-2c90-4d31-a9cd-4eab0aed1309').Name | Should -BeExactly $sesame
        }

        It 'writes the combined list as a superset of the providers' {
            $combined = Read-Data -Repo $repo -File 'combined_aaguid.json'
            $combined.Count | Should -Be (51 + $additional.Count)
            @($combined | Group-Object AAGUID | Where-Object Count -gt 1).Count | Should -Be 0
        }

        It 'writes data files as UTF-8 without a BOM and with LF line endings' {
            foreach ($file in 'aaguid.json', 'combined_aaguid.json') {
                $bytes = [IO.File]::ReadAllBytes((Join-Path $repo "data/$file"))
                $bytes[0] | Should -Not -Be 0xEF
                $bytes | Should -Not -Contain 13
            }
        }

        It 'regenerates the README tables to match the data' {
            $readme = Get-Content -Path (Join-Path $repo 'Readme.MD') -Raw
            foreach ($cache in @(@{ Marker = 'providers'; File = 'aaguid.json' }, @{ Marker = 'mds'; File = 'combined_aaguid.json' })) {
                $block = [regex]::Match($readme, "(?s)<!-- AAGUIDS:$($cache.Marker):start -->(.*?)<!-- AAGUIDS:$($cache.Marker):end -->").Groups[1].Value
                $rows = @($block -split "`r?`n" | Where-Object { $_ -match $guidLine })
                $rows.Count | Should -Be (Read-Data -Repo $repo -File $cache.File).Count
            }
            if ($readmeHadCrLf) { $readme | Should -Not -Match "[^`r]`n" }
        }

        It 'changes nothing when run again with the same upstream data' {
            $before = Get-RepoState $repo
            $second = Invoke-Build -Repo $repo -Upstream $upstream
            $second.changed | Should -Be 'false'
            $second.version | Should -Be $first.version
            Get-RepoState $repo | Should -Be $before
        }

        It 'accepts a small number of removals' {
            $data = New-UpstreamData
            $data.Providers.Remove((New-TestGuid 1))
            $data.Combined.Remove((New-TestGuid 1))
            $result = Invoke-Build -Repo $repo -Upstream (Save-Upstream -Data $data)
            $result.changed | Should -Be 'true'
            (Read-Data -Repo $repo -File 'aaguid.json').AAGUID | Should -Not -Contain (New-TestGuid 1)
        }
    }

    It 'does not bump the version with -NoVersionBump' {
        $repo = New-TestRepo
        $version = Get-ManifestVersion $repo
        $result = Invoke-Build -Repo $repo -Upstream (Save-Upstream -Data (New-UpstreamData)) -NoVersionBump
        $result.changed | Should -Be 'true'
        Get-ManifestVersion $repo | Should -Be $version
    }

    It 'uses the upstream entry when upstream already includes an additional AAGUID' {
        $repo = New-TestRepo
        $data = New-UpstreamData
        $data.Providers[$additional[0].AAGUID] = @{ name = 'Upstream Authenticator' }
        $data.Combined[$additional[0].AAGUID] = @{ name = 'Upstream Authenticator' }
        Invoke-Build -Repo $repo -Upstream (Save-Upstream -Data $data) | Out-Null

        foreach ($file in 'aaguid.json', 'combined_aaguid.json') {
            $matching = @(Read-Data -Repo $repo -File $file | Where-Object AAGUID -eq $additional[0].AAGUID)
            $matching.Count | Should -Be 1
            $matching[0].Name | Should -Be 'Upstream Authenticator'
        }
    }

    Context 'rejects bad upstream data without changing any files' {
        It 'rejects <Case>' -ForEach @(
            @{ Case = 'an empty file'; Message = 'is empty' }
            @{ Case = 'an empty object'; Message = 'contains no entries' }
            @{ Case = 'malformed JSON'; Message = 'not valid JSON' }
            @{ Case = 'a JSON array'; Message = 'not a JSON object' }
            @{ Case = 'an invalid AAGUID'; Message = 'not a valid lowercase AAGUID' }
            @{ Case = 'an uppercase AAGUID'; Message = 'not a valid lowercase AAGUID' }
            @{ Case = 'an empty name'; Message = 'empty or missing name' }
            @{ Case = 'a missing name'; Message = 'empty or missing name' }
            @{ Case = 'a replacement character'; Message = 'control or replacement characters' }
            @{ Case = 'a control character'; Message = 'control or replacement characters' }
            @{ Case = 'a truncated list'; Message = 'would remove' }
            @{ Case = 'a provider missing from the combined list'; Message = 'missing from combined' }
        ) {
            $repo = New-TestRepo
            Invoke-Build -Repo $repo -Upstream (Save-Upstream -Data (New-UpstreamData)) | Out-Null
            $before = Get-RepoState $repo

            $data = New-UpstreamData
            $providersJson = $null
            switch ($Case) {
                'an empty file' { $providersJson = ' ' }
                'an empty object' { $providersJson = '{}' }
                'malformed JSON' { $providersJson = '{"6028b017-b1d4-4c02-b4b3-afcdafc96bb2": {"name": "Windows Hello"' }
                'a JSON array' { $providersJson = '[{"name": "Windows Hello"}]' }
                'an invalid AAGUID' { $data.Providers['not-a-guid'] = @{ name = 'Bad' } }
                'an uppercase AAGUID' { $data.Providers['ABCDEF01-0000-4000-8000-000000000001'] = @{ name = 'Upper' } }
                'an empty name' { $data.Providers[(New-TestGuid 5000)] = @{ name = '' } }
                'a missing name' { $data.Providers[(New-TestGuid 5000)] = @{ icon_light = 'data:image/png;base64,' } }
                'a replacement character' { $data.Providers[(New-TestGuid 5000)] = @{ name = "Bad $([char]0xFFFD) name" } }
                'a control character' { $data.Providers[(New-TestGuid 5000)] = @{ name = "Bad`tname" } }
                'a truncated list' { foreach ($i in 1..5) { $data.Providers.Remove((New-TestGuid $i)) } }
                'a provider missing from the combined list' { $data.Combined.Remove((New-TestGuid 1)) }
            }
            $upstream = Save-Upstream -Data $data -ProvidersJson $providersJson

            { Invoke-Build -Repo $repo -Upstream $upstream } | Should -Throw -ExpectedMessage "*$Message*"
            Get-RepoState $repo | Should -Be $before
        }

        It 'rejects a README without the table markers' {
            $repo = New-TestRepo
            $readmePath = Join-Path $repo 'Readme.MD'
            Set-Content -Path $readmePath -Value ((Get-Content -Path $readmePath -Raw).Replace('<!-- AAGUIDS:mds:end -->', '')) -NoNewline
            $before = Get-RepoState $repo

            { Invoke-Build -Repo $repo -Upstream (Save-Upstream -Data (New-UpstreamData)) } | Should -Throw -ExpectedMessage '*markers*'
            Get-RepoState $repo | Should -Be $before
        }
    }
}
