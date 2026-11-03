Function Get-AAGUIDs {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [switch]$MDS,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [switch]$cache
    )
    <#
.SYNOPSIS

Programatically manage Passkey Providers AAGUIDS.
The FIDO2 specification requires each security key vendor to provide an Authenticator Attestation GUID (AAGUID) during registration. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. Passkey providers on desktop and mobile devices are also expected to provide an AAGUID during registration.

.DESCRIPTION

Return a list of AAGUIDs for Passkey Providers

.PARAMETER cache

If the cache switch is used the function will return a cached list of AAGUIDs for Passkey Providers

.PARAMETER MDS

If the MDS switch is used the function will return a list of AAGUIDs for Passkey Providers that are MDS compliant

.OUTPUTS

PowerShell Object

.SYNTAX

Get-AAGUIDs

.EXAMPLE

PS> Get-AAGUIDs
or
PS> Get-AAGUIDs -MDS
or
PS> Get-AAGUIDs -cache
or
PS> Get-AAGUIDs -MDS -cache

.LINK

https://blog.darrenjrobinson.com
https://blog.darrenjrobinson.com/passkey_provider_aaguids/

#>
    try {
        $dataPath = Join-Path $PSScriptRoot 'data'

        if ($cache) {
            # Cached lists are refreshed weekly from the PassKey Developer list by build/Update-AAGUIDCache.ps1
            if ($MDS) {
                $cacheFile = Join-Path $dataPath 'combined_aaguid.json'
            }
            else {
                $cacheFile = Join-Path $dataPath 'aaguid.json'
            }
            # Parentheses enumerate the array in Windows PowerShell 5.1, where ConvertFrom-Json emits it as one object
            return (Get-Content -Path $cacheFile -Raw -Encoding UTF8 | ConvertFrom-Json) | Sort-Object Name
        }
        else {
            if ($MDS -eq $false) {
                $Path = 'https://raw.githubusercontent.com/passkeydeveloper/passkey-authenticator-aaguids/refs/heads/main/aaguid.json'
            }
            else {
                $Path = 'https://raw.githubusercontent.com/passkeydeveloper/passkey-authenticator-aaguids/refs/heads/main/combined_aaguid.json'
            }
        }
        $result = Invoke-RestMethod -Method Get -Uri $Path -ContentType 'application/json'
        # Count the AAGUID properties rather than $result.Length, which is $null for a PSCustomObject in Windows PowerShell 5.1
        $guidsList = @()
        if ($result -is [PSCustomObject]) {
            $guidsList = @($result.PSObject.Properties | Select-Object -ExpandProperty Name)
        }
        if ($guidsList.Count -gt 0) {
            $AAGuids = @()

            foreach ($AAGuid in $guidsList) {
                $customObject = [PSCustomObject]@{
                    AAGUID = $AAGuid
                    Name   = $result.$AAGuid.name
                }
                $AAGuids += $customObject
            }

            # Add AAGUIDs not (yet) in the PassKey Developer list, e.g. Microsoft Authenticator for iOS and Android
            $additional = Get-Content -Path (Join-Path $dataPath 'additional_aaguids.json') -Raw -Encoding UTF8 | ConvertFrom-Json
            foreach ($customObject in $additional) {
                if ($guidsList -notcontains $customObject.AAGUID) {
                    $AAGuids += $customObject
                }
            }

            return $AAGuids | Sort-Object Name
        }
        else {
            Write-Error "No data returned from $($Path). Try using the '-cache' parameter to utilise a historical list."
        }
    }
    catch {
        if ($_.ErrorDetails.Message) {
            Write-Error $_.ErrorDetails.Message
        }
        else {
            Write-Error $_.Exception.Message
        }
    }
}
