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
        if ($cache) {
            if ($MDS) {
                return @'
[
  {
    "AAGUID": "bada5566-a7aa-401f-bd96-45619a55120d",
    "Name": "1Password"
  },
  {
    "AAGUID": "50a45b0c-80e7-f944-bf29-f552bfa2e048",
    "Name": "ACS FIDO Authenticator"
  },
  {
    "AAGUID": "973446ca-e21c-9a9b-99f5-9b985a67af0f",
    "Name": "ACS FIDO Authenticator Card"
  },
  {
    "AAGUID": "5ca1ab1e-fa57-1337-f1d0-a117371ca702",
    "Name": "Allthenticator Android App: roaming BLE FIDO2 Allthenticator for Windows, Mac, Linux, and Allthenticate door readers"
  },
  {
    "AAGUID": "5ca1ab1e-1337-fa57-f1d0-a117e71ca702",
    "Name": "Allthenticator iOS App: roaming BLE FIDO2 Allthenticator for Windows, Mac, Linux, and Allthenticate door readers"
  },
  {
    "AAGUID": "b93fd961-f2e6-462f-b122-82002247de78",
    "Name": "Android Authenticator with SafetyNet Attestation"
  },
  {
    "AAGUID": "3f59672f-20aa-4afe-b6f4-7e5e916b6d98",
    "Name": "Arculus FIDO 2.1 Key Card [P71]"
  },
  {
    "AAGUID": "9d3df6ba-282f-11ed-a261-0242ac120002",
    "Name": "Arculus FIDO2/U2F Key Card"
  },
  {
    "AAGUID": "d41f5a69-b817-4144-a13c-9ebd6d9254d6",
    "Name": "ATKey.Card CTAP2.0"
  },
  {
    "AAGUID": "da1fa263-8b25-42b6-a820-c0036f21ba7f",
    "Name": "ATKey.Card NFC"
  },
  {
    "AAGUID": "e1a96183-5016-4f24-b55b-e3ae23614cc6",
    "Name": "ATKey.Pro CTAP2.0"
  },
  {
    "AAGUID": "e416201b-afeb-41ca-a03d-2281c28322aa",
    "Name": "ATKey.Pro CTAP2.1"
  },
  {
    "AAGUID": "ba76a271-6eb6-4171-874d-b6428dbe3437",
    "Name": "ATKey.ProS"
  },
  {
    "AAGUID": "1c086528-58d5-f211-823c-356786e36140",
    "Name": "Atos CardOS FIDO2"
  },
  {
    "AAGUID": "b267239b-954f-4041-a01b-ee4f33c145b6",
    "Name": "authenton1 - CTAP2.1"
  },
  {
    "AAGUID": "d548826e-79b4-db40-a3d8-11116f7e8349",
    "Name": "Bitwarden"
  },
  {
    "AAGUID": "adce0002-35bc-c60a-648b-0b25f1f05503",
    "Name": "Chrome on Mac"
  },
  {
    "AAGUID": "b5397666-4885-aa6b-cebf-e52262a439a2",
    "Name": "Chromium Browser"
  },
  {
    "AAGUID": "175cd298-83d2-4a26-b637-313c07a6434e",
    "Name": "Chunghwa Telecom FIDO2 Smart Card Authenticator"
  },
  {
    "AAGUID": "be727034-574a-f799-5c76-0929e0430973",
    "Name": "Crayonic KeyVault K1 (USB-NFC-BLE FIDO2 Authenticator)"
  },
  {
    "AAGUID": "9c835346-796b-4c27-8898-d6032f515cc5",
    "Name": "Cryptnox FIDO2"
  },
  {
    "AAGUID": "6dae43be-af9c-417b-8b9f-1b611168ec60",
    "Name": "Dapple Authenticator from Dapple Security Inc."
  },
  {
    "AAGUID": "531126d6-e717-415c-9320-3d9aa6981239",
    "Name": "Dashlane"
  },
  {
    "AAGUID": "de503f9c-21a4-4f76-b4b7-558eb55c6f89",
    "Name": "Devolutions"
  },
  {
    "AAGUID": "771b48fd-d3d4-4f74-9232-fc157ab0507a",
    "Name": "Edge on Mac"
  },
  {
    "AAGUID": "1105e4ed-af1d-02ff-ffff-ffffffffffff",
    "Name": "Egomet FIDO2 Authenticator for Android"
  },
  {
    "AAGUID": "eb3b131e-59dc-536a-d176-cb7306da10f5",
    "Name": "ellipticSecure MIRkey USB Authenticator"
  },
  {
    "AAGUID": "f3809540-7f14-49c1-a8b3-8f813b225541",
    "Name": "Enpass"
  },
  {
    "AAGUID": "454e5346-4944-4ffd-6c93-8e9267193e9b",
    "Name": "Ensurity AUTH BioPro"
  },
  {
    "AAGUID": "454e5346-4944-4ffd-6c93-8e9267193e9a",
    "Name": "Ensurity ThinC"
  },
  {
    "AAGUID": "5343502d-5343-5343-6172-644649444f32",
    "Name": "ESS Smart Card Inc. Authenticator"
  },
  {
    "AAGUID": "95442b2e-f15e-4def-b270-efb106facb4e",
    "Name": "eWBM eFA310 FIDO2 Authenticator"
  },
  {
    "AAGUID": "87dbc5a1-4c94-4dc8-8a47-97d800fd1f3c",
    "Name": "eWBM eFA320 FIDO2 Authenticator"
  },
  {
    "AAGUID": "361a3082-0278-4583-a16f-72a527f973e4",
    "Name": "eWBM eFA500 FIDO2 Authenticator"
  },
  {
    "AAGUID": "61250591-b2bc-4456-b719-0b17be90bb30",
    "Name": "eWBM eFPA FIDO2 Authenticator"
  },
  {
    "AAGUID": "6002f033-3c07-ce3e-d0f7-0ffe5ed42543",
    "Name": "Excelsecu eSecu FIDO2 Fingerprint Key"
  },
  {
    "AAGUID": "d384db22-4d50-ebde-2eac-5765cf1e2a44",
    "Name": "Excelsecu eSecu FIDO2 Fingerprint Security Key"
  },
  {
    "AAGUID": "20f0be98-9af9-986a-4b42-8eca4acb28e4",
    "Name": "Excelsecu eSecu FIDO2 Fingerprint Security Key"
  },
  {
    "AAGUID": "a3975549-b191-fd67-b8fb-017e2917fdb3",
    "Name": "Excelsecu eSecu FIDO2 NFC Security Key"
  },
  {
    "AAGUID": "fbefdf68-fe86-0106-213e-4d5fa24cbe2e",
    "Name": "Excelsecu eSecu FIDO2 NFC Security Key"
  },
  {
    "AAGUID": "bbf4b6a7-679d-f6fc-c4f2-8ac0ddf9015a",
    "Name": "Excelsecu eSecu FIDO2 PRO Security Key"
  },
  {
    "AAGUID": "0d9b2e56-566b-c393-2940-f821b7f15d6d",
    "Name": "Excelsecu eSecu FIDO2 Pro Security Key"
  },
  {
    "AAGUID": "cdbdaea2-c415-5073-50f7-c04e968640b6",
    "Name": "Excelsecu eSecu FIDO2 Security Key"
  },
  {
    "AAGUID": "12ded745-4bed-47d4-abaa-e713f51d6393",
    "Name": "Feitian AllinOne FIDO2 Authenticator"
  },
  {
    "AAGUID": "77010bd7-212a-4fc9-b236-d2ca5e9d4084",
    "Name": "Feitian BioPass FIDO2 Authenticator"
  },
  {
    "AAGUID": "b6ede29c-3772-412c-8a78-539c1f4c62d2",
    "Name": "Feitian BioPass FIDO2 Plus Authenticator"
  },
  {
    "AAGUID": "4c0cf95d-2f40-43b5-ba42-4c83a11c04ba",
    "Name": "Feitian BioPass FIDO2 Pro Authenticator"
  },
  {
    "AAGUID": "833b721a-ff5f-4d00-bb2e-bdda3ec01e29",
    "Name": "Feitian ePass FIDO2 Authenticator"
  },
  {
    "AAGUID": "ee041bce-25e5-4cdb-8f86-897fd6418464",
    "Name": "Feitian ePass FIDO2-NFC Authenticator"
  },
  {
    "AAGUID": "260e3021-482d-442d-838c-7edfbe153b7e",
    "Name": "Feitian ePass FIDO2-NFC Plus Authenticator"
  },
  {
    "AAGUID": "234cd403-35a2-4cc2-8015-77ea280c77f5",
    "Name": "Feitian ePass FIDO2-NFC Series (CTAP2.1, CTAP2.0, U2F)"
  },
  {
    "AAGUID": "2c0df832-92de-4be1-8412-88a8f074df4a",
    "Name": "Feitian FIDO Smart Card"
  },
  {
    "AAGUID": "3e22415d-7fdf-4ea4-8a0c-dd60c4249b9d",
    "Name": "Feitian iePass FIDO Authenticator"
  },
  {
    "AAGUID": "ca87cb70-4c1b-4579-a8e8-4efdd7c007e0",
    "Name": "FIDO Alliance TruU Sample FIDO2 Authenticator"
  },
  {
    "AAGUID": "f4c63eff-d26c-4248-801c-3736c7eaa93a",
    "Name": "FIDO KeyPass S3"
  },
  {
    "AAGUID": "8c97a730-3f7b-41a6-87d6-1e9b62bda6f0",
    "Name": "FT-JCOS FIDO Fingerprint Card"
  },
  {
    "AAGUID": "ea9b8d66-4d01-1d21-3ce4-b6b48cb575d4",
    "Name": "Google Password Manager"
  },
  {
    "AAGUID": "42b4fb4a-2866-43b2-9bf7-6c6669c2e5d3",
    "Name": "Google Titan Security Key v2"
  },
  {
    "AAGUID": "9f0d8150-baa5-4c00-9299-ad62c8bb4e87",
    "Name": "GoTrust Idem Card FIDO2 Authenticator"
  },
  {
    "AAGUID": "3b1adb99-0dfe-46fd-90b8-7f7614a4de2a",
    "Name": "GoTrust Idem Key FIDO2 Authenticator"
  },
  {
    "AAGUID": "2a55aee6-27cb-42c0-bc6e-04efe999e88a",
    "Name": "HID Crescendo 4000"
  },
  {
    "AAGUID": "aeb6569c-f8fb-4950-ac60-24ca2bbe2e52",
    "Name": "HID Crescendo C2300"
  },
  {
    "AAGUID": "c80dbd9a-533f-4a17-b941-1a2f1c7cedff",
    "Name": "HID Crescendo C3000"
  },
  {
    "AAGUID": "54d9fee8-e621-4291-8b18-7157b99c5bec",
    "Name": "HID Crescendo Enabled"
  },
  {
    "AAGUID": "692db549-7ae5-44d5-a1e5-dd20a493b723",
    "Name": "HID Crescendo Key"
  },
  {
    "AAGUID": "2d3bec26-15ee-4f5d-88b2-53622490270b",
    "Name": "HID Crescendo Key V2"
  },
  {
    "AAGUID": "3e078ffd-4c54-4586-8baa-a77da113aec5",
    "Name": "Hideez Key 3 FIDO2"
  },
  {
    "AAGUID": "4e768f2c-5fab-48b3-b300-220eb487752b",
    "Name": "Hideez Key 4 FIDO2 SDK"
  },
  {
    "AAGUID": "d821a7d4-e97c-4cb6-bd82-4237731fd4be",
    "Name": "Hyper FIDO Bio Security Key"
  },
  {
    "AAGUID": "9f77e279-a6e2-4d58-b700-31e5943c6a98",
    "Name": "Hyper FIDO Pro"
  },
  {
    "AAGUID": "0076631b-d4a0-427f-5773-0ec71c9e0279",
    "Name": "HYPR FIDO2 Authenticator"
  },
  {
    "AAGUID": "fbfc3007-154e-4ecc-8c0b-6e020557d7bd",
    "Name": "iCloud Keychain"
  },
  {
    "AAGUID": "dd4ec289-e01d-41c9-bb89-70fa845d4bf2",
    "Name": "iCloud Keychain (Managed)"
  },
  {
    "AAGUID": "bb405265-40cf-4115-93e5-a332c1968d8c",
    "Name": "ID-One Card"
  },
  {
    "AAGUID": "e86addcd-7711-47e5-b42a-c18257b0bf61",
    "Name": "IDCore 3121 Fido"
  },
  {
    "AAGUID": "8d1b1fcb-3c76-49a9-9129-5515b346aa02",
    "Name": "IDEMIA ID-ONE Card"
  },
  {
    "AAGUID": "39a5647e-1853-446c-a1f6-a79bae9f5bc7",
    "Name": "IDmelon"
  },
  {
    "AAGUID": "820d89ed-d65a-409e-85cb-f73f0578f82a",
    "Name": "IDmelon iOS Authenticator"
  },
  {
    "AAGUID": "ca4cff1b-5a81-4404-8194-59aabcf1660b",
    "Name": "IDPrime 3930 FIDO"
  },
  {
    "AAGUID": "b50d5e0a-7f81-4959-9b12-f45407407503",
    "Name": "IDPrime 3940 FIDO"
  },
  {
    "AAGUID": "2194b428-9397-4046-8f39-007a1605a482",
    "Name": "IDPrime 931 Fido"
  },
  {
    "AAGUID": "2ffd6452-01da-471f-821b-ea4bf6c8676a",
    "Name": "IDPrime 941 Fido"
  },
  {
    "AAGUID": "4b89f401-464e-4745-a520-486ddfc5d80e",
    "Name": "IIST FIDO2 Authenticator"
  },
  {
    "AAGUID": "4c50ff10-1057-4fc6-b8ed-43a529530c3c",
    "Name": "ImproveID Authenticator"
  },
  {
    "AAGUID": "bfc748bb-3429-4faa-b9f9-7cfa9f3b76d0",
    "Name": "iPasswords"
  },
  {
    "AAGUID": "fdb141b2-5d84-443e-8a35-4698c205a502",
    "Name": "KeePassXC"
  },
  {
    "AAGUID": "0ea242b4-43c4-4a1b-8b17-dd6d0b6baec6",
    "Name": "Keeper"
  },
  {
    "AAGUID": "d91c5288-0ef0-49b7-b8ae-21ca0aa6b3f3",
    "Name": "KEY-ID FIDO2 Authenticator"
  },
  {
    "AAGUID": "d61d3b87-3e7c-4aea-9c50-441c371903ad",
    "Name": "KeyVault Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "4b3f8944-d4f2-4d21-bb19-764a986ec160",
    "Name": "KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "ec31b4cc-2acc-4b8e-9c01-bade00ccbe26",
    "Name": "KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "f7c558a0-f465-11e8-b568-0800200c9a66",
    "Name": "KONAI Secp256R1 FIDO2 Conformance Testing CTAP2 Authenticator"
  },
  {
    "AAGUID": "fec067a1-f1d0-4c5e-b4c0-cc3237475461",
    "Name": "KX701 SmartToken FIDO"
  },
  {
    "AAGUID": "b78a0a55-6ef8-d246-a042-ba0f6d55050c",
    "Name": "LastPass"
  },
  {
    "AAGUID": "341e4da9-3c2e-8103-5a9f-aad887135200",
    "Name": "Ledger Nano S FIDO2 Authenticator"
  },
  {
    "AAGUID": "58b44d0b-0a7c-f33a-fd48-f7153c871352",
    "Name": "Ledger Nano S Plus FIDO2 Authenticator"
  },
  {
    "AAGUID": "fcb1bcb4-f370-078c-6993-bc24d0ae3fbe",
    "Name": "Ledger Nano X FIDO2 Authenticator"
  },
  {
    "AAGUID": "de1e552d-db1d-4423-a619-566b625cdc84",
    "Name": "Microsoft Authenticator for Android (Preview)"
  },
  {
    "AAGUID": "90a3ccdf-635c-4729-a248-9b709135078f",
    "Name": "Microsoft Authenticator for iOS (Preview)"
  },
  {
    "AAGUID": "c5703116-972b-4851-a3e7-ae1259843399",
    "Name": "NEOWAVE Badgeo FIDO2"
  },
  {
    "AAGUID": "3789da91-f943-46bc-95c3-50ea2012f03a",
    "Name": "NEOWAVE Winkeo FIDO2"
  },
  {
    "AAGUID": "2cd2f727-f6ca-44da-8f48-5c2e5da000a2",
    "Name": "Nitrokey 3 AM"
  },
  {
    "AAGUID": "b84e4048-15dc-4dd0-8640-f4f60813c8af",
    "Name": "NordPass"
  },
  {
    "AAGUID": "07a9f89c-6407-4594-9d56-621d5f1e358b",
    "Name": "NXP Semiconductros FIDO2 Conformance Testing CTAP2 Authenticator"
  },
  {
    "AAGUID": "0acf3011-bc60-f375-fb53-6f05f43154e0",
    "Name": "Nymi FIDO2 Authenticator"
  },
  {
    "AAGUID": "a1f52be5-dfab-4364-b51c-2bd496b14a56",
    "Name": "OCTATCO EzFinger2 FIDO2 AUTHENTICATOR"
  },
  {
    "AAGUID": "bc2fe499-0d8e-4ffe-96f3-94a82840cf8c",
    "Name": "OCTATCO EzQuant FIDO2 AUTHENTICATOR"
  },
  {
    "AAGUID": "69e7c36f-f2f6-9e0d-07a6-bcc243262e6b",
    "Name": "OneKey FIDO2 Authenticator"
  },
  {
    "AAGUID": "30b5035e-d297-4ff1-b00b-addc96ba6a98",
    "Name": "OneSpan DIGIPASS FX1 BIO"
  },
  {
    "AAGUID": "30b5035e-d297-4ff1-010b-addc96ba6a98",
    "Name": "OneSpan DIGIPASS FX1a"
  },
  {
    "AAGUID": "30b5035e-d297-4ff7-b00b-addc96ba6a98",
    "Name": "OneSpan DIGIPASS FX7"
  },
  {
    "AAGUID": "30b5035e-d297-4fc1-b00b-addc96ba6a97",
    "Name": "OneSpan FIDO Touch"
  },
  {
    "AAGUID": "998f358b-2dd2-4cbe-a43a-e8107438dfb3",
    "Name": "OnlyKey Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "664d9f67-84a2-412a-9ff7-b4f7d8ee6d05",
    "Name": "OpenSK authenticator"
  },
  {
    "AAGUID": "09591fc6-9811-48f7-8f57-b9f23df6413f",
    "Name": "Pone Biometrics OFFPAD Authenticator"
  },
  {
    "AAGUID": "69700f79-d1fb-472e-bd9b-a3a3b9a9eda0",
    "Name": "Pone Biometrics OFFPAD Authenticator"
  },
  {
    "AAGUID": "88bbd2f0-342a-42e7-9729-dd158be5407a",
    "Name": "Precision InnaIT Key FIDO 2 Level 2 certified"
  },
  {
    "AAGUID": "50726f74-6f6e-5061-7373-50726f746f6e",
    "Name": "Proton Pass"
  },
  {
    "AAGUID": "59f85fe7-faa5-4c92-9f52-697b9d4d5473",
    "Name": "RSA Authenticator 4 for Android"
  },
  {
    "AAGUID": "8681a073-5f50-4d52-bce4-e21658d207b3",
    "Name": "RSA Authenticator 4 for iOS"
  },
  {
    "AAGUID": "7e3f3d30-3557-4442-bdae-139312178b39",
    "Name": "RSA DS100"
  },
  {
    "AAGUID": "efb96b10-a9ee-4b6c-a4a9-d32125ccd4a4",
    "Name": "Safenet eToken FIDO"
  },
  {
    "AAGUID": "74820b05-a6c9-40f9-8fb0-9f86aca93998",
    "Name": "SafeNet eToken Fusion"
  },
  {
    "AAGUID": "23786452-f02d-4344-87ed-aaf703726881",
    "Name": "SafeNet eToken Fusion CC"
  },
  {
    "AAGUID": "53414d53-554e-4700-0000-000000000000",
    "Name": "Samsung Pass"
  },
  {
    "AAGUID": "b92c3f9a-c014-4056-887f-140a2501163b",
    "Name": "Security Key by Yubico"
  },
  {
    "AAGUID": "f8a011f3-8c0a-4d15-8006-17111f9edc7d",
    "Name": "Security Key by Yubico"
  },
  {
    "AAGUID": "149a2021-8ef6-4133-96b8-81f8d5b7f1f5",
    "Name": "Security Key by Yubico with NFC"
  },
  {
    "AAGUID": "6d44ba9b-f6ec-2e49-b930-0c8fe920cb73",
    "Name": "Security Key by Yubico with NFC"
  },
  {
    "AAGUID": "e77e3c64-05e3-428b-8824-0cbeb04b829d",
    "Name": "Security Key NFC by Yubico"
  },
  {
    "AAGUID": "a4e9fc6d-4cbe-4758-b8ba-37598bb5bbaa",
    "Name": "Security Key NFC by Yubico"
  },
  {
    "AAGUID": "47ab2fb4-66ac-4184-9ae1-86be814012d5",
    "Name": "Security Key NFC by Yubico - Enterprise Edition"
  },
  {
    "AAGUID": "0bb43545-fd2c-4185-87dd-feb0b2916ace",
    "Name": "Security Key NFC by Yubico - Enterprise Edition"
  },
  {
    "AAGUID": "9ff4cc65-6154-4fff-ba09-9e2af7882ad2",
    "Name": "Security Key NFC by Yubico - Enterprise Edition (Enterprise Profile)"
  },
  {
    "AAGUID": "2772ce93-eb4b-4090-8b73-330f48477d73",
    "Name": "Security Key NFC by Yubico - Enterprise Edition Preview"
  },
  {
    "AAGUID": "760eda36-00aa-4d29-855b-4012a182cdeb",
    "Name": "Security Key NFC by Yubico Preview"
  },
  {
    "AAGUID": "89b19028-256b-4025-8872-255358d950e4",
    "Name": "Sentry Enterprises CTAP2 Authenticator"
  },
  {
    "AAGUID": "891494da-2c90-4d31-a9cd-4eab0aed1309",
    "Name": "Sésame"
  },
  {
    "AAGUID": "516d3969-5a57-5651-5958-4e7a49434167",
    "Name": "SmartDisplayer BobeePass FIDO2 Authenticator"
  },
  {
    "AAGUID": "8876631b-d4a0-427f-5773-0ec71c9e0279",
    "Name": "Solo Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "8976631b-d4a0-427f-5773-0ec71c9e0279",
    "Name": "Solo Tap Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "9876631b-d4a0-427f-5773-0ec71c9e0279",
    "Name": "Somu Secp256R1 FIDO2 CTAP2 Authenticator"
  },
  {
    "AAGUID": "931327dd-c89b-406c-a81e-ed7058ef36c6",
    "Name": "Swissbit iShield Key FIDO2"
  },
  {
    "AAGUID": "5d629218-d3a5-11ed-afa1-0242ac120002",
    "Name": "Swissbit iShield Key Pro"
  },
  {
    "AAGUID": "092277e5-8437-46b5-b911-ea64b294acb7",
    "Name": "Taglio CTAP2.1 CS"
  },
  {
    "AAGUID": "7d2afadd-bf6b-44a2-a66b-e831fceb8eff",
    "Name": "Taglio CTAP2.1 EP"
  },
  {
    "AAGUID": "ab32f0c6-2239-afbb-c470-d2ef4e254db6",
    "Name": "TEST (DUMMY RECORD)"
  },
  {
    "AAGUID": "8836336a-f590-0921-301d-46427531eee6",
    "Name": "Thales Bio Android SDK"
  },
  {
    "AAGUID": "66a0ccb3-bd6a-191f-ee06-e375c50b9846",
    "Name": "Thales Bio iOS SDK"
  },
  {
    "AAGUID": "4d41190c-7beb-4a84-8018-adf265a6352d",
    "Name": "Thales IDPrime FIDO Bio"
  },
  {
    "AAGUID": "cd69adb5-3c7a-deb9-3177-6800ea6cb72a",
    "Name": "Thales PIN Android SDK"
  },
  {
    "AAGUID": "17290f1e-c212-34d0-1423-365d729f09d9",
    "Name": "Thales PIN iOS SDK"
  },
  {
    "AAGUID": "91ad6b93-264b-4987-8737-3a690cad6917",
    "Name": "Token Ring FIDO2 Authenticator"
  },
  {
    "AAGUID": "ab32f0c6-2239-afbb-c470-d2ef4e254db7",
    "Name": "TOKEN2 FIDO2 Security Key"
  },
  {
    "AAGUID": "eabb46cc-e241-80bf-ae9e-96fa6d2975cf",
    "Name": "TOKEN2 PIN Plus Security Key Series "
  },
  {
    "AAGUID": "cc45f64e-52a2-451b-831a-4edd8022a202",
    "Name": "ToothPic Passkey Provider"
  },
  {
    "AAGUID": "95e4d58c-056e-4a65-866d-f5a69659e880",
    "Name": "TruU Windows Authenticator"
  },
  {
    "AAGUID": "ba86dc56-635f-4141-aef6-00227b1b9af6",
    "Name": "TruU Windows Authenticator"
  },
  {
    "AAGUID": "cfcb13a2-244f-4b36-9077-82b79d6a7de7",
    "Name": "USB/NFC Passcode Authenticator"
  },
  {
    "AAGUID": "73402251-f2a8-4f03-873e-3cb6db604b03",
    "Name": "uTrust FIDO2 Security Key"
  },
  {
    "AAGUID": "5626bed4-e756-430b-a7ff-ca78c8b12738",
    "Name": "VALMIDO PRO FIDO"
  },
  {
    "AAGUID": "d94a29d9-52dd-4247-9c2d-8b818b610389",
    "Name": "VeriMark Guard Fingerprint Key"
  },
  {
    "AAGUID": "99ed6c29-4573-4847-816d-78ad8f1c75ef",
    "Name": "VeroCard FIDO2 Authenticator"
  },
  {
    "AAGUID": "5fdb81b8-53f0-4967-a881-f5ec26fe4d18",
    "Name": "VinCSS FIDO2 Authenticator"
  },
  {
    "AAGUID": "d7a423ad-3e19-4492-9200-78137dccc136",
    "Name": "VivoKey Apex FIDO2"
  },
  {
    "AAGUID": "6028b017-b1d4-4c02-b4b3-afcdafc96bb2",
    "Name": "Windows Hello"
  },
  {
    "AAGUID": "08987058-cadc-4b81-b6e1-30de50dcbe96",
    "Name": "Windows Hello"
  },
  {
    "AAGUID": "9ddd1817-af5a-4672-a2b9-3e3dd95000a9",
    "Name": "Windows Hello"
  },
  {
    "AAGUID": "f56f58b3-d711-4afc-ba7d-6ac05f88cb19",
    "Name": "WinMagic FIDO Eazy - Phone"
  },
  {
    "AAGUID": "31c3f7ff-bf15-4327-83ec-9336abcbcd34",
    "Name": "WinMagic FIDO Eazy - Software"
  },
  {
    "AAGUID": "970c8d9c-19d2-46af-aa32-3f448db49e35",
    "Name": "WinMagic FIDO Eazy - TPM"
  },
  {
    "AAGUID": "504d7149-4e4c-3841-4555-55445a677357",
    "Name": "WiSECURE AuthTron USB FIDO2 Authenticator"
  },
  {
    "AAGUID": "5753362b-4e6b-6345-7b2f-255438404c75",
    "Name": "WiSECURE Blentity FIDO2 Authenticator"
  },
  {
    "AAGUID": "73bb0cd4-e502-49b8-9c6f-b59445bf720b",
    "Name": "YubiKey 5 FIPS Series"
  },
  {
    "AAGUID": "85203421-48f9-4355-9bc8-8a53846e5083",
    "Name": "YubiKey 5 FIPS Series with Lightning"
  },
  {
    "AAGUID": "5b0e46ba-db02-44ac-b979-ca9b84f5e335",
    "Name": "YubiKey 5 FIPS Series with Lightning Preview"
  },
  {
    "AAGUID": "c1f9a0bc-1dd2-404a-b27f-8e29047a43fd",
    "Name": "YubiKey 5 FIPS Series with NFC"
  },
  {
    "AAGUID": "62e54e98-c209-4df3-b692-de71bb6a8528",
    "Name": "YubiKey 5 FIPS Series with NFC Preview"
  },
  {
    "AAGUID": "ee882879-721c-4913-9775-3dfcce97072a",
    "Name": "YubiKey 5 Series"
  },
  {
    "AAGUID": "19083c3d-8383-4b18-bc03-8f1c9ab2fd1b",
    "Name": "YubiKey 5 Series"
  },
  {
    "AAGUID": "cb69481e-8ff7-4039-93ec-0a2729a154a8",
    "Name": "YubiKey 5 Series"
  },
  {
    "AAGUID": "20ac7a17-c814-4833-93fe-539f0d5e3389",
    "Name": "YubiKey 5 Series (Enterprise Profile)"
  },
  {
    "AAGUID": "c5ef55ff-ad9a-4b9f-b580-adebafe026d0",
    "Name": "YubiKey 5 Series with Lightning"
  },
  {
    "AAGUID": "a02167b9-ae71-4ac7-9a07-06432ebb6f1c",
    "Name": "YubiKey 5 Series with Lightning"
  },
  {
    "AAGUID": "b90e7dc1-316e-4fee-a25a-56a666a670fe",
    "Name": "YubiKey 5 Series with Lightning (Enterprise Profile)"
  },
  {
    "AAGUID": "3124e301-f14e-4e38-876d-fbeeb090e7bf",
    "Name": "YubiKey 5 Series with Lightning Preview"
  },
  {
    "AAGUID": "fa2b99dc-9e39-4257-8f92-4a30d23c4118",
    "Name": "YubiKey 5 Series with NFC"
  },
  {
    "AAGUID": "a25342c0-3cdc-4414-8e46-f4807fca511c",
    "Name": "YubiKey 5 Series with NFC"
  },
  {
    "AAGUID": "2fc0579f-8113-47ea-b116-bb5a8db9202a",
    "Name": "YubiKey 5 Series with NFC"
  },
  {
    "AAGUID": "1ac71f64-468d-4fe0-bef1-0e5f2f551f18",
    "Name": "YubiKey 5 Series with NFC (Enterprise Profile)"
  },
  {
    "AAGUID": "34f5766d-1536-4a24-9033-0e294e510fb0",
    "Name": "YubiKey 5 Series with NFC Preview"
  },
  {
    "AAGUID": "dd86a2da-86a0-4cbe-b462-4bd31f57bc6f",
    "Name": "YubiKey Bio FIDO Edition"
  },
  {
    "AAGUID": "d8522d9f-575b-4866-88a9-ba99fa02f35b",
    "Name": "YubiKey Bio Series"
  },
  {
    "AAGUID": "7d1351a6-e097-4852-b8bf-c9ac5c9ce4a3",
    "Name": "YubiKey Bio Series - Multi-protocol Edition"
  },
  {
    "AAGUID": "90636e1f-ef82-43bf-bdcf-5255f139d12f",
    "Name": "YubiKey Bio Series - Multi-protocol Edition"
  },
  {
    "AAGUID": "97e6a830-c952-4740-95fc-7c78dc97ce47",
    "Name": "YubiKey Bio Series - Multi-protocol Edition (Enterprise Profile)"
  },
  {
    "AAGUID": "58276709-bb4b-4bb3-baf1-60eea99282a7",
    "Name": "YubiKey Bio Series - Multi-protocol Edition 1VDJSN"
  },
  {
    "AAGUID": "83c47309-aabb-4108-8470-8be838b573cb",
    "Name": "YubiKey Bio Series (Enterprise Profile)"
  },
  {
    "AAGUID": "8c39ee86-7f9a-4a95-9ba3-f6b097e5c2ee",
    "Name": "YubiKey Bio Series (Enterprise Profile)"
  },
  {
    "AAGUID": "b35a26b2-8f6e-4697-ab1d-d44db4da28c6",
    "Name": "Zoho Vault"
  },
  {
    "AAGUID": "99bf4610-ec26-4252-b31f-7380ccd59db5",
    "Name": "ZTPass SmartAuth"
  }
]
'@ | ConvertFrom-Json | Sort-Object Name
            }
            else {
                return @'
          [
  {
    "AAGUID": "bada5566-a7aa-401f-bd96-45619a55120d",
    "Name": "1Password"
  },
  {
    "AAGUID": "d548826e-79b4-db40-a3d8-11116f7e8349",
    "Name": "Bitwarden"
  },
  {
    "AAGUID": "adce0002-35bc-c60a-648b-0b25f1f05503",
    "Name": "Chrome on Mac"
  },
  {
    "AAGUID": "b5397666-4885-aa6b-cebf-e52262a439a2",
    "Name": "Chromium Browser"
  },
  {
    "AAGUID": "531126d6-e717-415c-9320-3d9aa6981239",
    "Name": "Dashlane"
  },
  {
    "AAGUID": "de503f9c-21a4-4f76-b4b7-558eb55c6f89",
    "Name": "Devolutions"
  },
  {
    "AAGUID": "771b48fd-d3d4-4f74-9232-fc157ab0507a",
    "Name": "Edge on Mac"
  },
  {
    "AAGUID": "f3809540-7f14-49c1-a8b3-8f813b225541",
    "Name": "Enpass"
  },
  {
    "AAGUID": "ea9b8d66-4d01-1d21-3ce4-b6b48cb575d4",
    "Name": "Google Password Manager"
  },
  {
    "AAGUID": "fbfc3007-154e-4ecc-8c0b-6e020557d7bd",
    "Name": "iCloud Keychain"
  },
  {
    "AAGUID": "dd4ec289-e01d-41c9-bb89-70fa845d4bf2",
    "Name": "iCloud Keychain (Managed)"
  },
  {
    "AAGUID": "39a5647e-1853-446c-a1f6-a79bae9f5bc7",
    "Name": "IDmelon"
  },
  {
    "AAGUID": "bfc748bb-3429-4faa-b9f9-7cfa9f3b76d0",
    "Name": "iPasswords"
  },
  {
    "AAGUID": "fdb141b2-5d84-443e-8a35-4698c205a502",
    "Name": "KeePassXC"
  },
  {
    "AAGUID": "0ea242b4-43c4-4a1b-8b17-dd6d0b6baec6",
    "Name": "Keeper"
  },
  {
    "AAGUID": "b78a0a55-6ef8-d246-a042-ba0f6d55050c",
    "Name": "LastPass"
  },
  {
    "AAGUID": "de1e552d-db1d-4423-a619-566b625cdc84",
    "Name": "Microsoft Authenticator for Android (Preview)"
  },
  {
    "AAGUID": "90a3ccdf-635c-4729-a248-9b709135078f",
    "Name": "Microsoft Authenticator for iOS (Preview)"
  },
  {
    "AAGUID": "b84e4048-15dc-4dd0-8640-f4f60813c8af",
    "Name": "NordPass"
  },
  {
    "AAGUID": "50726f74-6f6e-5061-7373-50726f746f6e",
    "Name": "Proton Pass"
  },
  {
    "AAGUID": "53414d53-554e-4700-0000-000000000000",
    "Name": "Samsung Pass"
  },
  {
    "AAGUID": "891494da-2c90-4d31-a9cd-4eab0aed1309",
    "Name": "Sésame"
  },
  {
    "AAGUID": "8836336a-f590-0921-301d-46427531eee6",
    "Name": "Thales Bio Android SDK"
  },
  {
    "AAGUID": "66a0ccb3-bd6a-191f-ee06-e375c50b9846",
    "Name": "Thales Bio iOS SDK"
  },
  {
    "AAGUID": "cd69adb5-3c7a-deb9-3177-6800ea6cb72a",
    "Name": "Thales PIN Android SDK"
  },
  {
    "AAGUID": "17290f1e-c212-34d0-1423-365d729f09d9",
    "Name": "Thales PIN iOS SDK"
  },
  {
    "AAGUID": "cc45f64e-52a2-451b-831a-4edd8022a202",
    "Name": "ToothPic Passkey Provider"
  },
  {
    "AAGUID": "9ddd1817-af5a-4672-a2b9-3e3dd95000a9",
    "Name": "Windows Hello"
  },
  {
    "AAGUID": "6028b017-b1d4-4c02-b4b3-afcdafc96bb2",
    "Name": "Windows Hello"
  },
  {
    "AAGUID": "08987058-cadc-4b81-b6e1-30de50dcbe96",
    "Name": "Windows Hello"
  },
  {
    "AAGUID": "b35a26b2-8f6e-4697-ab1d-d44db4da28c6",
    "Name": "Zoho Vault"
  }
]
'@ | ConvertFrom-Json | Sort-Object Name
            }
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
        if ($result.Length -gt 0) {
            $AAGuids = @()
            $guidsList = $result | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

            foreach ($AAGuid in $guidsList) {
                $customObject = [PSCustomObject]@{
                    AAGUID = $AAGuid
                    Name   = $result.$AAGuid.name
                }
                $AAGuids += $customObject
            }

            $customObject = [PSCustomObject]@{
                AAGUID = "de1e552d-db1d-4423-a619-566b625cdc84"
                Name   = "Microsoft Authenticator for Android (Preview)"
            } 
            $AAGuids += $customObject

            $customObject = [PSCustomObject]@{
                AAGUID = "90a3ccdf-635c-4729-a248-9b709135078f"
                Name   = "Microsoft Authenticator for iOS (Preview)"
            }

            $AAGuids += $customObject
            
            return $AAGuids | Sort-Object Name
        }
        else {
            Write-Error "No data returned from $($Path). Try using the '$cache' parameter to utilise a historical list."
        }
    }
    catch {
        Write-Error $_.ErrorDetails.Message
    }
}
# SIG # Begin signature block
# MIIoJQYJKoZIhvcNAQcCoIIoFjCCKBICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDUWvUKWOpc+Khj
# bh/79kj0mFsnCYmQeE8zEWSZOo+9UqCCISgwggWNMIIEdaADAgECAhAOmxiO+dAt
# 5+/bUOIIQBhaMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNV
# BAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yMjA4MDEwMDAwMDBa
# Fw0zMTExMDkyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
# dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lD
# ZXJ0IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoC
# ggIBAL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprNrnsbhA3E
# MB/zG6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKy
# unWZanMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4IWGbNOsF
# xl7sWxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13jrclPXuU1
# 5zHL2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJB
# MtfbBHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQnvKFPObUR
# WBf3JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu5tTvkpI6
# nj3cAORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/8tWMcCxB
# YKqxYxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5S
# UUd0viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+x
# q4aLT8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGjggE6MIIB
# NjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTs1+OC0nFdZEzfLmc/57qYrhwP
# TzAfBgNVHSMEGDAWgBRF66Kv9JLLgjEtUYunpyGd823IDzAOBgNVHQ8BAf8EBAMC
# AYYweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdp
# Y2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNv
# bS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0
# aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENB
# LmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQEMBQADggEBAHCgv0Nc
# Vec4X6CjdBs9thbX979XB72arKGHLOyFXqkauyL4hxppVCLtpIh3bb0aFPQTSnov
# Lbc47/T/gLn4offyct4kvFIDyE7QKt76LVbP+fT3rDB6mouyXtTP0UNEm0Mh65Zy
# oUi0mcudT6cGAxN3J0TU53/oWajwvy8LpunyNDzs9wPHh6jSTEAZNUZqaVSwuKFW
# juyk1T3osdz9HNj0d1pcVIxv76FQPfx2CWiEn2/K2yCNNWAcAgPLILCsWKAOQGPF
# mCLBsln1VWvPJ6tsds5vIy30fnFqI2si/xK4VC0nftg62fC2h5b9W9FcrBjDTZ9z
# twGpn1eqXijiuZQwggauMIIElqADAgECAhAHNje3JFR82Ees/ShmKl5bMA0GCSqG
# SIb3DQEBCwUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMx
# GTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0IFRy
# dXN0ZWQgUm9vdCBHNDAeFw0yMjAzMjMwMDAwMDBaFw0zNzAzMjIyMzU5NTlaMGMx
# CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMy
# RGlnaUNlcnQgVHJ1c3RlZCBHNCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcg
# Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDGhjUGSbPBPXJJUVXH
# JQPE8pE3qZdRodbSg9GeTKJtoLDMg/la9hGhRBVCX6SI82j6ffOciQt/nR+eDzMf
# UBMLJnOWbfhXqAJ9/UO0hNoR8XOxs+4rgISKIhjf69o9xBd/qxkrPkLcZ47qUT3w
# 1lbU5ygt69OxtXXnHwZljZQp09nsad/ZkIdGAHvbREGJ3HxqV3rwN3mfXazL6IRk
# tFLydkf3YYMZ3V+0VAshaG43IbtArF+y3kp9zvU5EmfvDqVjbOSmxR3NNg1c1eYb
# qMFkdECnwHLFuk4fsbVYTXn+149zk6wsOeKlSNbwsDETqVcplicu9Yemj052FVUm
# cJgmf6AaRyBD40NjgHt1biclkJg6OBGz9vae5jtb7IHeIhTZgirHkr+g3uM+onP6
# 5x9abJTyUpURK1h0QCirc0PO30qhHGs4xSnzyqqWc0Jon7ZGs506o9UD4L/wojzK
# QtwYSH8UNM/STKvvmz3+DrhkKvp1KCRB7UK/BZxmSVJQ9FHzNklNiyDSLFc1eSuo
# 80VgvCONWPfcYd6T/jnA+bIwpUzX6ZhKWD7TA4j+s4/TXkt2ElGTyYwMO1uKIqjB
# Jgj5FBASA31fI7tk42PgpuE+9sJ0sj8eCXbsq11GdeJgo1gJASgADoRU7s7pXche
# MBK9Rp6103a50g5rmQzSM7TNsQIDAQABo4IBXTCCAVkwEgYDVR0TAQH/BAgwBgEB
# /wIBADAdBgNVHQ4EFgQUuhbZbU2FL3MpdpovdYxqII+eyG8wHwYDVR0jBBgwFoAU
# 7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoG
# CCsGAQUFBwMIMHcGCCsGAQUFBwEBBGswaTAkBggrBgEFBQcwAYYYaHR0cDovL29j
# c3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAChjVodHRwOi8vY2FjZXJ0cy5kaWdp
# Y2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNydDBDBgNVHR8EPDA6MDig
# NqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9v
# dEc0LmNybDAgBgNVHSAEGTAXMAgGBmeBDAEEAjALBglghkgBhv1sBwEwDQYJKoZI
# hvcNAQELBQADggIBAH1ZjsCTtm+YqUQiAX5m1tghQuGwGC4QTRPPMFPOvxj7x1Bd
# 4ksp+3CKDaopafxpwc8dB+k+YMjYC+VcW9dth/qEICU0MWfNthKWb8RQTGIdDAiC
# qBa9qVbPFXONASIlzpVpP0d3+3J0FNf/q0+KLHqrhc1DX+1gtqpPkWaeLJ7giqzl
# /Yy8ZCaHbJK9nXzQcAp876i8dU+6WvepELJd6f8oVInw1YpxdmXazPByoyP6wCeC
# RK6ZJxurJB4mwbfeKuv2nrF5mYGjVoarCkXJ38SNoOeY+/umnXKvxMfBwWpx2cYT
# gAnEtp/Nh4cku0+jSbl3ZpHxcpzpSwJSpzd+k1OsOx0ISQ+UzTl63f8lY5knLD0/
# a6fxZsNBzU+2QJshIUDQtxMkzdwdeDrknq3lNHGS1yZr5Dhzq6YBT70/O3itTK37
# xJV77QpfMzmHQXh6OOmc4d0j/R0o08f56PGYX/sr2H7yRp11LB4nLCbbbxV7HhmL
# NriT1ObyF5lZynDwN7+YAN8gFk8n+2BnFqFmut1VwDophrCYoCvtlUG3OtUVmDG0
# YgkPCr2B2RP+v6TR81fZvAT6gt4y3wSJ8ADNXcL50CN/AAvkdgIm2fBldkKmKYcJ
# RyvmfxqkhQ/8mJb2VVQrH4D6wPIOK+XW+6kvRBVK5xMOHds3OBqhK/bt1nz8MIIG
# sDCCBJigAwIBAgIQCK1AsmDSnEyfXs2pvZOu2TANBgkqhkiG9w0BAQwFADBiMQsw
# CQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cu
# ZGlnaWNlcnQuY29tMSEwHwYDVQQDExhEaWdpQ2VydCBUcnVzdGVkIFJvb3QgRzQw
# HhcNMjEwNDI5MDAwMDAwWhcNMzYwNDI4MjM1OTU5WjBpMQswCQYDVQQGEwJVUzEX
# MBUGA1UEChMORGlnaUNlcnQsIEluYy4xQTA/BgNVBAMTOERpZ2lDZXJ0IFRydXN0
# ZWQgRzQgQ29kZSBTaWduaW5nIFJTQTQwOTYgU0hBMzg0IDIwMjEgQ0ExMIICIjAN
# BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA1bQvQtAorXi3XdU5WRuxiEL1M4zr
# PYGXcMW7xIUmMJ+kjmjYXPXrNCQH4UtP03hD9BfXHtr50tVnGlJPDqFX/IiZwZHM
# gQM+TXAkZLON4gh9NH1MgFcSa0OamfLFOx/y78tHWhOmTLMBICXzENOLsvsI8Irg
# nQnAZaf6mIBJNYc9URnokCF4RS6hnyzhGMIazMXuk0lwQjKP+8bqHPNlaJGiTUyC
# EUhSaN4QvRRXXegYE2XFf7JPhSxIpFaENdb5LpyqABXRN/4aBpTCfMjqGzLmysL0
# p6MDDnSlrzm2q2AS4+jWufcx4dyt5Big2MEjR0ezoQ9uo6ttmAaDG7dqZy3SvUQa
# khCBj7A7CdfHmzJawv9qYFSLScGT7eG0XOBv6yb5jNWy+TgQ5urOkfW+0/tvk2E0
# XLyTRSiDNipmKF+wc86LJiUGsoPUXPYVGUztYuBeM/Lo6OwKp7ADK5GyNnm+960I
# HnWmZcy740hQ83eRGv7bUKJGyGFYmPV8AhY8gyitOYbs1LcNU9D4R+Z1MI3sMJN2
# FKZbS110YU0/EpF23r9Yy3IQKUHw1cVtJnZoEUETWJrcJisB9IlNWdt4z4FKPkBH
# X8mBUHOFECMhWWCKZFTBzCEa6DgZfGYczXg4RTCZT/9jT0y7qg0IU0F8WD1Hs/q2
# 7IwyCQLMbDwMVhECAwEAAaOCAVkwggFVMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
# VR0OBBYEFGg34Ou2O/hfEYb7/mF7CIhl9E5CMB8GA1UdIwQYMBaAFOzX44LScV1k
# TN8uZz/nupiuHA9PMA4GA1UdDwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcD
# AzB3BggrBgEFBQcBAQRrMGkwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2lj
# ZXJ0LmNvbTBBBggrBgEFBQcwAoY1aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29t
# L0RpZ2lDZXJ0VHJ1c3RlZFJvb3RHNC5jcnQwQwYDVR0fBDwwOjA4oDagNIYyaHR0
# cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZFJvb3RHNC5jcmww
# HAYDVR0gBBUwEzAHBgVngQwBAzAIBgZngQwBBAEwDQYJKoZIhvcNAQEMBQADggIB
# ADojRD2NCHbuj7w6mdNW4AIapfhINPMstuZ0ZveUcrEAyq9sMCcTEp6QRJ9L/Z6j
# fCbVN7w6XUhtldU/SfQnuxaBRVD9nL22heB2fjdxyyL3WqqQz/WTauPrINHVUHmI
# moqKwba9oUgYftzYgBoRGRjNYZmBVvbJ43bnxOQbX0P4PpT/djk9ntSZz0rdKOtf
# JqGVWEjVGv7XJz/9kNF2ht0csGBc8w2o7uCJob054ThO2m67Np375SFTWsPK6Wrx
# oj7bQ7gzyE84FJKZ9d3OVG3ZXQIUH0AzfAPilbLCIXVzUstG2MQ0HKKlS43Nb3Y3
# LIU/Gs4m6Ri+kAewQ3+ViCCCcPDMyu/9KTVcH4k4Vfc3iosJocsL6TEa/y4ZXDlx
# 4b6cpwoG1iZnt5LmTl/eeqxJzy6kdJKt2zyknIYf48FWGysj/4+16oh7cGvmoLr9
# Oj9FpsToFpFSi0HASIRLlk2rREDjjfAVKM7t8RhWByovEMQMCGQ8M4+uKIw8y4+I
# Cw2/O/TOHnuO77Xry7fwdxPm5yg/rBKupS8ibEH5glwVZsxsDsrFhsP2JjMMB0ug
# 0wcCampAMEhLNKhRILutG4UI4lkNbcoFUCvqShyepf2gpx8GdOfy1lKQ/a+FSCH5
# Vzu0nAPthkX0tGFuv2jiJmCG6sivqf6UHedjGzqGVnhOMIIGvDCCBKSgAwIBAgIQ
# C65mvFq6f5WHxvnpBOMzBDANBgkqhkiG9w0BAQsFADBjMQswCQYDVQQGEwJVUzEX
# MBUGA1UEChMORGlnaUNlcnQsIEluYy4xOzA5BgNVBAMTMkRpZ2lDZXJ0IFRydXN0
# ZWQgRzQgUlNBNDA5NiBTSEEyNTYgVGltZVN0YW1waW5nIENBMB4XDTI0MDkyNjAw
# MDAwMFoXDTM1MTEyNTIzNTk1OVowQjELMAkGA1UEBhMCVVMxETAPBgNVBAoTCERp
# Z2lDZXJ0MSAwHgYDVQQDExdEaWdpQ2VydCBUaW1lc3RhbXAgMjAyNDCCAiIwDQYJ
# KoZIhvcNAQEBBQADggIPADCCAgoCggIBAL5qc5/2lSGrljC6W23mWaO16P2RHxjE
# iDtqmeOlwf0KMCBDEr4IxHRGd7+L660x5XltSVhhK64zi9CeC9B6lUdXM0s71EOc
# Re8+CEJp+3R2O8oo76EO7o5tLuslxdr9Qq82aKcpA9O//X6QE+AcaU/byaCagLD/
# GLoUb35SfWHh43rOH3bpLEx7pZ7avVnpUVmPvkxT8c2a2yC0WMp8hMu60tZR0Cha
# V76Nhnj37DEYTX9ReNZ8hIOYe4jl7/r419CvEYVIrH6sN00yx49boUuumF9i2T8U
# uKGn9966fR5X6kgXj3o5WHhHVO+NBikDO0mlUh902wS/Eeh8F/UFaRp1z5SnROHw
# SJ+QQRZ1fisD8UTVDSupWJNstVkiqLq+ISTdEjJKGjVfIcsgA4l9cbk8Smlzddh4
# EfvFrpVNnes4c16Jidj5XiPVdsn5n10jxmGpxoMc6iPkoaDhi6JjHd5ibfdp5uzI
# Xp4P0wXkgNs+CO/CacBqU0R4k+8h6gYldp4FCMgrXdKWfM4N0u25OEAuEa3Jyidx
# W48jwBqIJqImd93NRxvd1aepSeNeREXAu2xUDEW8aqzFQDYmr9ZONuc2MhTMizch
# NULpUEoA6Vva7b1XCB+1rxvbKmLqfY/M/SdV6mwWTyeVy5Z/JkvMFpnQy5wR14GJ
# cv6dQ4aEKOX5AgMBAAGjggGLMIIBhzAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/
# BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAgBgNVHSAEGTAXMAgGBmeBDAEE
# AjALBglghkgBhv1sBwEwHwYDVR0jBBgwFoAUuhbZbU2FL3MpdpovdYxqII+eyG8w
# HQYDVR0OBBYEFJ9XLAN3DigVkGalY17uT5IfdqBbMFoGA1UdHwRTMFEwT6BNoEuG
# SWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNFJTQTQw
# OTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMCQG
# CCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wWAYIKwYBBQUHMAKG
# TGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNFJT
# QTQwOTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcnQwDQYJKoZIhvcNAQELBQADggIB
# AD2tHh92mVvjOIQSR9lDkfYR25tOCB3RKE/P09x7gUsmXqt40ouRl3lj+8QioVYq
# 3igpwrPvBmZdrlWBb0HvqT00nFSXgmUrDKNSQqGTdpjHsPy+LaalTW0qVjvUBhcH
# zBMutB6HzeledbDCzFzUy34VarPnvIWrqVogK0qM8gJhh/+qDEAIdO/KkYesLyTV
# OoJ4eTq7gj9UFAL1UruJKlTnCVaM2UeUUW/8z3fvjxhN6hdT98Vr2FYlCS7Mbb4H
# v5swO+aAXxWUm3WpByXtgVQxiBlTVYzqfLDbe9PpBKDBfk+rabTFDZXoUke7zPgt
# d7/fvWTlCs30VAGEsshJmLbJ6ZbQ/xll/HjO9JbNVekBv2Tgem+mLptR7yIrpaid
# RJXrI+UzB6vAlk/8a1u7cIqV0yef4uaZFORNekUgQHTqddmsPCEIYQP7xGxZBIhd
# mm4bhYsVA6G2WgNFYagLDBzpmk9104WQzYuVNsxyoVLObhx3RugaEGru+SojW4dH
# PoWrUhftNpFC5H7QEY7MhKRyrBe7ucykW7eaCuWBsBb4HOKRFVDcrZgdwaSIqMDi
# CLg4D+TPVgKx2EgEdeoHNHT9l3ZDBD+XgbF+23/zBjeCtxz+dL/9NWR6P2eZRi7z
# cEO1xwcdcqJsyz/JceENc2Sg8h3KeFUCS7tpFk7CrDqkMIIHbTCCBVWgAwIBAgIQ
# CcjsXDR9ByBZzKg16Kdv+DANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJVUzEX
# MBUGA1UEChMORGlnaUNlcnQsIEluYy4xQTA/BgNVBAMTOERpZ2lDZXJ0IFRydXN0
# ZWQgRzQgQ29kZSBTaWduaW5nIFJTQTQwOTYgU0hBMzg0IDIwMjEgQ0ExMB4XDTIz
# MDMyOTAwMDAwMFoXDTI2MDYyMjIzNTk1OVowdTELMAkGA1UEBhMCQVUxGDAWBgNV
# BAgTD05ldyBTb3V0aCBXYWxlczEUMBIGA1UEBxMLQ2hlcnJ5YnJvb2sxGjAYBgNV
# BAoTEURhcnJlbiBKIFJvYmluc29uMRowGAYDVQQDExFEYXJyZW4gSiBSb2JpbnNv
# bjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMesp+e1UZ5doOnpL+ep
# m6Iq6GYiqK8ZNcz1XBe7M7eBXwVy4tYP5ByIa6NORYEselVWI9XmO1M+cPS6jRMr
# pZb9xtUH+NpKZO+eSthgTAtnEO1dWaAK6Y7AH/ZVjmgOTWZXBVibjAE/JQKIfZyx
# 4Hm5FOH6hq3bslA+RUQpo3NQxNv2AuzckKQwbW7AoXINudj0duYCiDYshn/9mHzz
# gL0VpNYRpmgEa7WWgc1JH17V+SYlaf6qMWpYoWuODwuDltSH2p57qAI2/4J6rUYE
# vns7QZ9sgIUdGlUr596fp0Y4juypyVGE7Rr0a8PtByLWUupyV7Z5kKPr/MRjerXA
# mBnf6AdhI3kY6Gjz356fZkPA49UuCIXFgyTZT84Ao6Klw+0RqJ70JDt449Uky7hd
# a+h8h2PiUdf7rXQamV57mY65+lHAmc4+UgTuWsnpwnTuNlkbZxRnCw2D+W3qto2a
# BhDebciKZzivfiAWlWfTcHtCpy96gM5L+OB45ezDpU6KAH1hwRSjORUlW5yoFTXU
# bPUBRflU3O2bZ0wdAJeyUYaHWAayNoyFfuKdrmCLtIx726O06dz9Kg+cJf+1ZdJ7
# KcUvZgR2d8F19FV5G1CVMnOzhMZR2dnIeJ5h0EgcOKNHl3hMKFdVRx4lhW8tcrQQ
# N4ZT2EgGfI9fBc0i3GXTFA0xAgMBAAGjggIDMIIB/zAfBgNVHSMEGDAWgBRoN+Dr
# tjv4XxGG+/5hewiIZfROQjAdBgNVHQ4EFgQUBTFWqXTuYnNp+d03es2KM9JdGUgw
# DgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMIG1BgNVHR8Ega0w
# gaowU6BRoE+GTWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0
# ZWRHNENvZGVTaWduaW5nUlNBNDA5NlNIQTM4NDIwMjFDQTEuY3JsMFOgUaBPhk1o
# dHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkRzRDb2RlU2ln
# bmluZ1JTQTQwOTZTSEEzODQyMDIxQ0ExLmNybDA+BgNVHSAENzA1MDMGBmeBDAEE
# ATApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgZQG
# CCsGAQUFBwEBBIGHMIGEMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2Vy
# dC5jb20wXAYIKwYBBQUHMAKGUGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9E
# aWdpQ2VydFRydXN0ZWRHNENvZGVTaWduaW5nUlNBNDA5NlNIQTM4NDIwMjFDQTEu
# Y3J0MAkGA1UdEwQCMAAwDQYJKoZIhvcNAQELBQADggIBAFhACWjPMrcafwDfZ5me
# /nUrkv4yYgIi535cddPAm/2swGDTuzSVBVHIMBp8LWLmzXPA1GbxBOmA4L8vvDgj
# EpQF9I9Ph5MNYgYhg0xSpAIp9/KAoc4OQnwlyRGPN+CjayY40xxTz4/hHohWg4rn
# JMIuVEjkMtKnMdTbpnqU85w78AQlfD79v/gWQ2dL1T3n18HOEjTt8VSurxkEhQ5I
# 3SH8Cr9YhUv94ObWIUbOKUt5SG7m/d+y2mfkKRSOmRluLSoYLPWbx35pArsYkaPp
# jf5Yl5jiJPY3GQzEU/SRVW0rrwDAbtKSN0gKWtZxijPDbs8aQUYCijFfje6OWGF4
# RnmPSQh0Ff8AyzPQcx9LjQ/8W7gUELsE6IFuXP5bj2i6geLy65LRe46QZlYDq/bM
# azUoZQTlje/hs6pkOL4f1Kv7tbJZmMENVVURJNmeDRejvNliHaaGEAv/iF0Zo7pq
# vj4wCCCGG3j/sNR5WSRYnxf5xQ4r9i9gZqk4yjwk/DJCW2rmKNCUoxNIZWh2EIlM
# SDzw3DMKk2ylZdiY/LAi5GmbCyGLt6sTz/IE1w1NYwrp/z6v4I91lDgdXg+fTkhh
# xt47hWmjMOD3ZYVSFzQmg8al1iQ/+6RYKgfsww64tIky8JOOZX/3ss/uhxKUjPJx
# YJkOwQwUyoAYzjcu/AE7By0rMYIGUzCCBk8CAQEwfTBpMQswCQYDVQQGEwJVUzEX
# MBUGA1UEChMORGlnaUNlcnQsIEluYy4xQTA/BgNVBAMTOERpZ2lDZXJ0IFRydXN0
# ZWQgRzQgQ29kZSBTaWduaW5nIFJTQTQwOTYgU0hBMzg0IDIwMjEgQ0ExAhAJyOxc
# NH0HIFnMqDXop2/4MA0GCWCGSAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAI
# oAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIB
# CzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIK7nhaB4cAKKZMdOL5cg
# GiwtfiK2FAh4NEpT+68PzAelMA0GCSqGSIb3DQEBAQUABIICALhoiMn8VHAgRcWh
# y+pZyljSZj6Y/eveclqLrKFahVgQtUwH8vVenh4/6eJrfokKTwHQOwQB5JywuLLH
# C7nV6NiH1AaVpycSFkwe5/S25QYKkaWYBcQxN6AlwCzRwPuJZbBRwIxtm4XV//UH
# 7cPSKMC4Y/iQmjQkB2IGGnEokU0hx1z27qByUWsXAL2r+clIgqJ1txYgWWfCBNUX
# 2PNnnbBLmVUuKHkTf0142Q5/6PHo14CMUHNmzizPh8mGOntf8aJErYrOzxL07+fC
# NRm4XNzCvK79ngpmZSMeC8uuMLpP6z3cwKtOACeZYvj280kxSX3eYAqwdyBdEV67
# 7tv4Mx1nLcfLy5EconqV2xbfRJQ+cu6DIIcj/f1GIB5na6iQFJrDvsis3FVQjyX5
# 3wz+NuU9uDa67/+XQ739l/Zbvts4tb76LMVqAKkqRS0xNXMsVSK8ib6/XNvszZRe
# 7nRrMYtNRx1bF2gL17eq4Axs14StFXjOL109nRy7lpQCcLwjV/La5bjQdq774C/d
# BO5vLWjGnkHAaTRMfh1F6K2PiGfXyyu+60GkmkCcruMgiSK7h0kik5tcK+MO0hEo
# Q7aTI9XdbASjdqifnUlyq+9guDie0IW6ReGaVhXGozTKtRZTurYEpf1iZVJczjVD
# 2eQNpVVLIKhpRC4RTsosS3o2as6AoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJ
# AgEBMHcwYzELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTsw
# OQYDVQQDEzJEaWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVT
# dGFtcGluZyBDQQIQC65mvFq6f5WHxvnpBOMzBDANBglghkgBZQMEAgEFAKBpMBgG
# CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTExNzIy
# MDgxN1owLwYJKoZIhvcNAQkEMSIEIOBVVSvyFLbkKeIVqPRv8k9NBE+OlxLZJ1ib
# QWRBhhpqMA0GCSqGSIb3DQEBAQUABIICAF3Rt3GOooDqOn77y7IAbzvBx4gI1uvh
# Mk2+459LQOFAtCTaFpMa7OZaOvivplSY5VQFGKZvOq9Nq2+ATN5WDEQUCfaRUyvN
# xxdOfJ9UqeVbsel0blGwmujsUp1eVkVZPfTRzDkGb6PHZEjKj0jyaBZZde3DFj2s
# eqOm/XtdJee/ewCXF2quCbsqi4DSa9CGwm/il3hYx90VNulKvUJZywd8HQ2th0ay
# cyqNVsh3f73cbukENwpGWMad5aAIiOj0kwsX0d28JZPssVk+KOgLFiEGaQwiMmMe
# l5tQqX++r5ytq3KFc96wK5qYjmmb71Tq64P0y+7k9vr6v0tXGK/y2SxdCwr4Mcov
# hs3o3QeN2QW0yD9NlqZ4HkdbIABkzw4BprKjHJTHTu8T8lJV+oYSLrw8K4P540je
# Ka4kmJ5bYo2DWJ0wNCZAvZayszx4Vn/KZB4Hpfxz8CQGO2UwmL5zI+L74BoAh68J
# jzNa+uz+aa0FpxpEsTY33u1WMTZTmU4YB9ByWEfW/BJCyshqwhbJUavxNWSZUwtJ
# 0KoEITo8UDFLbISDiJC5xwvo/7oDL3hdKoW9iPI/zCfpyvbsh2YvmvWe+ROQtPdW
# ksiHsT3ZjVl4uOUZrX23qS5oevvi0xCtEfRa9AURSNSQGArNshMn8VFg4GbrNC1q
# TxWkqBH9+nvo
# SIG # End signature block
