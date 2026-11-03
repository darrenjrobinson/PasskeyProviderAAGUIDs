@{
    RootModule           = 'PasskeyProviderAAGUIDs.psm1'
    ModuleVersion        = '1.0.2'
    GUID                 = '3deeae5e-dadd-420e-8523-ec6e7cdfd9c9'
    Author               = 'Darren J Robinson'
    Copyright            = '(c) 2024. All rights reserved.'
    Description          = "PowerShell Module to enable devops automation of AAGUID management of Passkey Providers. The FIDO2 specification requires each security key vendor to provide an Authenticator Attestation GUID (AAGUID) during registration. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. Passkey providers on desktop and mobile devices are also expected to provide an AAGUID during registration."
    PowerShellVersion    = '5.1'
    CompatiblePSEditions = 'Core', 'Desktop'
    FunctionsToExport    = @('Get-AAGUIDs')
    FileList             = @('PasskeyProviderAAGUIDs.psd1', 'PasskeyProviderAAGUIDs.psm1', 'data/aaguid.json', 'data/combined_aaguid.json', 'data/additional_aaguids.json')
    PrivateData          = @{
        PSData = @{
            ProjectUri = 'https://github.com/darrenjrobinson/PasskeyProviderAAGUIDs'
        } 
    } 
}
