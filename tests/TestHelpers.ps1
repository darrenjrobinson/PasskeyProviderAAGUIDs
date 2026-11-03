# Shared by the test files. AAGUID_MODULE_PATH points the Data and Module tests at a staged package folder
# (see build/New-ModulePackage.ps1); without it they test the repository itself.
function Get-TestModuleRoot {
    if ($env:AAGUID_MODULE_PATH) {
        return (Resolve-Path -Path $env:AAGUID_MODULE_PATH).Path
    }
    return (Resolve-Path -Path (Join-Path $PSScriptRoot '..')).Path
}

function Read-JsonFile {
    param ([string]$Path)

    # Parentheses enumerate the array in Windows PowerShell 5.1, where ConvertFrom-Json emits it as one object
    return @((Get-Content -Path $Path -Raw -Encoding UTF8 | ConvertFrom-Json))
}

$GuidPattern = '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z'
