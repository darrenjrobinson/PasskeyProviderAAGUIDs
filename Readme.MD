# Passkey Provider AAGUID's PowerShell Module

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PasskeyProviderAAGUIDs.svg?style=flat&logo=powershell&label=PSGallery%20Version)](https://www.powershellgallery.com/packages/PasskeyProviderAAGUIDs) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PasskeyProviderAAGUIDs.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)](https://www.powershellgallery.com/packages/PasskeyProviderAAGUIDs)

## Description

Programatically manage Passkey Providers AAGUID's.

The FIDO2 specification requires each security key vendor to provide an Authenticator Attestation GUID (AAGUID) during registration. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. Passkey providers on desktop and mobile devices are also expected to provide an AAGUID during registration.

The list is obtained from the [PassKey Developer Community Driven List](https://github.com/passkeydeveloper/passkey-authenticator-aaguids) with the addition inclusion of [Microsoft Authenticator for iOS and Android](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-enable-passkey-fido2#passkey-optional-settings?WT.mc_id=EM-MVP-5002871) 

## Installation

* From an Admin PowerShell session, install from the PowerShell Gallery

```powershell
install-module -name PasskeyProviderAAGUIDS
```

or download from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PasskeyProviderAAGUIDs)

## Parameters

### PARAMETER cache

If the cache switch is used the function will return a cached list of AAGUIDs for Passkey Providers

### PARAMETER MDS

If the MDS switch is used the function will return a list of AAGUIDs for Passkey Providers that are MDS compliant

## Examples

PS> Get-AAUIDs
or
PS> Get-AAGUIDs -MDS
or
PS> Get-AAGUIDs -cache
or
PS> Get-AAGUIDs -MDS -cache

# Get AAGUIDs and return those associated with Windows Hello
PS> Get-AAGUIDs -cache | Where-Object {$_.name -like '*hello*'}

```powershell
Get-AAGUIDs  
```

### Output

```powershell
AAGUID                               Name
------                               ----
bada5566-a7aa-401f-bd96-45619a55120d 1Password
d548826e-79b4-db40-a3d8-11116f7e8349 Bitwarden
adce0002-35bc-c60a-648b-0b25f1f05503 Chrome on Mac
b5397666-4885-aa6b-cebf-e52262a439a2 Chromium Browser
531126d6-e717-415c-9320-3d9aa6981239 Dashlane
de503f9c-21a4-4f76-b4b7-558eb55c6f89 Devolutions
771b48fd-d3d4-4f74-9232-fc157ab0507a Edge on Mac
f3809540-7f14-49c1-a8b3-8f813b225541 Enpass
ea9b8d66-4d01-1d21-3ce4-b6b48cb575d4 Google Password Manager
fbfc3007-154e-4ecc-8c0b-6e020557d7bd iCloud Keychain
dd4ec289-e01d-41c9-bb89-70fa845d4bf2 iCloud Keychain (Managed)
39a5647e-1853-446c-a1f6-a79bae9f5bc7 IDmelon
bfc748bb-3429-4faa-b9f9-7cfa9f3b76d0 iPasswords
fdb141b2-5d84-443e-8a35-4698c205a502 KeePassXC
0ea242b4-43c4-4a1b-8b17-dd6d0b6baec6 Keeper
b78a0a55-6ef8-d246-a042-ba0f6d55050c LastPass
de1e552d-db1d-4423-a619-566b625cdc84 Microsoft Authenticator for Android (Preview)
90a3ccdf-635c-4729-a248-9b709135078f Microsoft Authenticator for iOS (Preview)
b84e4048-15dc-4dd0-8640-f4f60813c8af NordPass
50726f74-6f6e-5061-7373-50726f746f6e Proton Pass
53414d53-554e-4700-0000-000000000000 Samsung Pass
891494da-2c90-4d31-a9cd-4eab0aed1309 Sésame
8836336a-f590-0921-301d-46427531eee6 Thales Bio Android SDK
66a0ccb3-bd6a-191f-ee06-e375c50b9846 Thales Bio iOS SDK
cd69adb5-3c7a-deb9-3177-6800ea6cb72a Thales PIN Android SDK
17290f1e-c212-34d0-1423-365d729f09d9 Thales PIN iOS SDK
cc45f64e-52a2-451b-831a-4edd8022a202 ToothPic Passkey Provider
9ddd1817-af5a-4672-a2b9-3e3dd95000a9 Windows Hello
6028b017-b1d4-4c02-b4b3-afcdafc96bb2 Windows Hello
08987058-cadc-4b81-b6e1-30de50dcbe96 Windows Hello
b35a26b2-8f6e-4697-ab1d-d44db4da28c6 Zoho Vault
```

Retrieve the combined MDS list from the built-in cache

```powershell
Get-AAGUIDs -MDS -cache
```

### Output

```powershell
AAGUID                               Name
------                               ----
bada5566-a7aa-401f-bd96-45619a55120d 1Password
50a45b0c-80e7-f944-bf29-f552bfa2e048 ACS FIDO Authenticator
973446ca-e21c-9a9b-99f5-9b985a67af0f ACS FIDO Authenticator Card
5ca1ab1e-fa57-1337-f1d0-a117371ca702 Allthenticator Android App: roaming BLE FIDO2 Allthenticator for Windows, Mac, Linux, and Allthenticate door readers
5ca1ab1e-1337-fa57-f1d0-a117e71ca702 Allthenticator iOS App: roaming BLE FIDO2 Allthenticator for Windows, Mac, Linux, and Allthenticate door readers
b93fd961-f2e6-462f-b122-82002247de78 Android Authenticator with SafetyNet Attestation
3f59672f-20aa-4afe-b6f4-7e5e916b6d98 Arculus FIDO 2.1 Key Card [P71]
9d3df6ba-282f-11ed-a261-0242ac120002 Arculus FIDO2/U2F Key Card
d41f5a69-b817-4144-a13c-9ebd6d9254d6 ATKey.Card CTAP2.0
da1fa263-8b25-42b6-a820-c0036f21ba7f ATKey.Card NFC
e1a96183-5016-4f24-b55b-e3ae23614cc6 ATKey.Pro CTAP2.0
e416201b-afeb-41ca-a03d-2281c28322aa ATKey.Pro CTAP2.1
ba76a271-6eb6-4171-874d-b6428dbe3437 ATKey.ProS
1c086528-58d5-f211-823c-356786e36140 Atos CardOS FIDO2
b267239b-954f-4041-a01b-ee4f33c145b6 authenton1 - CTAP2.1
d548826e-79b4-db40-a3d8-11116f7e8349 Bitwarden
adce0002-35bc-c60a-648b-0b25f1f05503 Chrome on Mac
b5397666-4885-aa6b-cebf-e52262a439a2 Chromium Browser
175cd298-83d2-4a26-b637-313c07a6434e Chunghwa Telecom FIDO2 Smart Card Authenticator
be727034-574a-f799-5c76-0929e0430973 Crayonic KeyVault K1 (USB-NFC-BLE FIDO2 Authenticator)
9c835346-796b-4c27-8898-d6032f515cc5 Cryptnox FIDO2
6dae43be-af9c-417b-8b9f-1b611168ec60 Dapple Authenticator from Dapple Security Inc.
531126d6-e717-415c-9320-3d9aa6981239 Dashlane
de503f9c-21a4-4f76-b4b7-558eb55c6f89 Devolutions
771b48fd-d3d4-4f74-9232-fc157ab0507a Edge on Mac
1105e4ed-af1d-02ff-ffff-ffffffffffff Egomet FIDO2 Authenticator for Android
eb3b131e-59dc-536a-d176-cb7306da10f5 ellipticSecure MIRkey USB Authenticator
f3809540-7f14-49c1-a8b3-8f813b225541 Enpass
454e5346-4944-4ffd-6c93-8e9267193e9b Ensurity AUTH BioPro
454e5346-4944-4ffd-6c93-8e9267193e9a Ensurity ThinC
5343502d-5343-5343-6172-644649444f32 ESS Smart Card Inc. Authenticator
95442b2e-f15e-4def-b270-efb106facb4e eWBM eFA310 FIDO2 Authenticator
87dbc5a1-4c94-4dc8-8a47-97d800fd1f3c eWBM eFA320 FIDO2 Authenticator
361a3082-0278-4583-a16f-72a527f973e4 eWBM eFA500 FIDO2 Authenticator
61250591-b2bc-4456-b719-0b17be90bb30 eWBM eFPA FIDO2 Authenticator
6002f033-3c07-ce3e-d0f7-0ffe5ed42543 Excelsecu eSecu FIDO2 Fingerprint Key
d384db22-4d50-ebde-2eac-5765cf1e2a44 Excelsecu eSecu FIDO2 Fingerprint Security Key
20f0be98-9af9-986a-4b42-8eca4acb28e4 Excelsecu eSecu FIDO2 Fingerprint Security Key
a3975549-b191-fd67-b8fb-017e2917fdb3 Excelsecu eSecu FIDO2 NFC Security Key
fbefdf68-fe86-0106-213e-4d5fa24cbe2e Excelsecu eSecu FIDO2 NFC Security Key
bbf4b6a7-679d-f6fc-c4f2-8ac0ddf9015a Excelsecu eSecu FIDO2 PRO Security Key
0d9b2e56-566b-c393-2940-f821b7f15d6d Excelsecu eSecu FIDO2 Pro Security Key
cdbdaea2-c415-5073-50f7-c04e968640b6 Excelsecu eSecu FIDO2 Security Key
12ded745-4bed-47d4-abaa-e713f51d6393 Feitian AllinOne FIDO2 Authenticator
77010bd7-212a-4fc9-b236-d2ca5e9d4084 Feitian BioPass FIDO2 Authenticator
b6ede29c-3772-412c-8a78-539c1f4c62d2 Feitian BioPass FIDO2 Plus Authenticator
4c0cf95d-2f40-43b5-ba42-4c83a11c04ba Feitian BioPass FIDO2 Pro Authenticator
833b721a-ff5f-4d00-bb2e-bdda3ec01e29 Feitian ePass FIDO2 Authenticator
ee041bce-25e5-4cdb-8f86-897fd6418464 Feitian ePass FIDO2-NFC Authenticator
260e3021-482d-442d-838c-7edfbe153b7e Feitian ePass FIDO2-NFC Plus Authenticator
234cd403-35a2-4cc2-8015-77ea280c77f5 Feitian ePass FIDO2-NFC Series (CTAP2.1, CTAP2.0, U2F)
2c0df832-92de-4be1-8412-88a8f074df4a Feitian FIDO Smart Card
3e22415d-7fdf-4ea4-8a0c-dd60c4249b9d Feitian iePass FIDO Authenticator
ca87cb70-4c1b-4579-a8e8-4efdd7c007e0 FIDO Alliance TruU Sample FIDO2 Authenticator
f4c63eff-d26c-4248-801c-3736c7eaa93a FIDO KeyPass S3
8c97a730-3f7b-41a6-87d6-1e9b62bda6f0 FT-JCOS FIDO Fingerprint Card
ea9b8d66-4d01-1d21-3ce4-b6b48cb575d4 Google Password Manager
42b4fb4a-2866-43b2-9bf7-6c6669c2e5d3 Google Titan Security Key v2
9f0d8150-baa5-4c00-9299-ad62c8bb4e87 GoTrust Idem Card FIDO2 Authenticator
3b1adb99-0dfe-46fd-90b8-7f7614a4de2a GoTrust Idem Key FIDO2 Authenticator
2a55aee6-27cb-42c0-bc6e-04efe999e88a HID Crescendo 4000
aeb6569c-f8fb-4950-ac60-24ca2bbe2e52 HID Crescendo C2300
c80dbd9a-533f-4a17-b941-1a2f1c7cedff HID Crescendo C3000
54d9fee8-e621-4291-8b18-7157b99c5bec HID Crescendo Enabled
692db549-7ae5-44d5-a1e5-dd20a493b723 HID Crescendo Key
2d3bec26-15ee-4f5d-88b2-53622490270b HID Crescendo Key V2
3e078ffd-4c54-4586-8baa-a77da113aec5 Hideez Key 3 FIDO2
4e768f2c-5fab-48b3-b300-220eb487752b Hideez Key 4 FIDO2 SDK
d821a7d4-e97c-4cb6-bd82-4237731fd4be Hyper FIDO Bio Security Key
9f77e279-a6e2-4d58-b700-31e5943c6a98 Hyper FIDO Pro
0076631b-d4a0-427f-5773-0ec71c9e0279 HYPR FIDO2 Authenticator
fbfc3007-154e-4ecc-8c0b-6e020557d7bd iCloud Keychain
dd4ec289-e01d-41c9-bb89-70fa845d4bf2 iCloud Keychain (Managed)
bb405265-40cf-4115-93e5-a332c1968d8c ID-One Card
e86addcd-7711-47e5-b42a-c18257b0bf61 IDCore 3121 Fido
8d1b1fcb-3c76-49a9-9129-5515b346aa02 IDEMIA ID-ONE Card
39a5647e-1853-446c-a1f6-a79bae9f5bc7 IDmelon
820d89ed-d65a-409e-85cb-f73f0578f82a IDmelon iOS Authenticator
ca4cff1b-5a81-4404-8194-59aabcf1660b IDPrime 3930 FIDO
b50d5e0a-7f81-4959-9b12-f45407407503 IDPrime 3940 FIDO
2194b428-9397-4046-8f39-007a1605a482 IDPrime 931 Fido
2ffd6452-01da-471f-821b-ea4bf6c8676a IDPrime 941 Fido
4b89f401-464e-4745-a520-486ddfc5d80e IIST FIDO2 Authenticator
4c50ff10-1057-4fc6-b8ed-43a529530c3c ImproveID Authenticator
bfc748bb-3429-4faa-b9f9-7cfa9f3b76d0 iPasswords
fdb141b2-5d84-443e-8a35-4698c205a502 KeePassXC
0ea242b4-43c4-4a1b-8b17-dd6d0b6baec6 Keeper
d91c5288-0ef0-49b7-b8ae-21ca0aa6b3f3 KEY-ID FIDO2 Authenticator
d61d3b87-3e7c-4aea-9c50-441c371903ad KeyVault Secp256R1 FIDO2 CTAP2 Authenticator
4b3f8944-d4f2-4d21-bb19-764a986ec160 KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator
ec31b4cc-2acc-4b8e-9c01-bade00ccbe26 KeyXentic FIDO2 Secp256R1 FIDO2 CTAP2 Authenticator
f7c558a0-f465-11e8-b568-0800200c9a66 KONAI Secp256R1 FIDO2 Conformance Testing CTAP2 Authenticator
fec067a1-f1d0-4c5e-b4c0-cc3237475461 KX701 SmartToken FIDO
b78a0a55-6ef8-d246-a042-ba0f6d55050c LastPass
341e4da9-3c2e-8103-5a9f-aad887135200 Ledger Nano S FIDO2 Authenticator
58b44d0b-0a7c-f33a-fd48-f7153c871352 Ledger Nano S Plus FIDO2 Authenticator
fcb1bcb4-f370-078c-6993-bc24d0ae3fbe Ledger Nano X FIDO2 Authenticator
de1e552d-db1d-4423-a619-566b625cdc84 Microsoft Authenticator for Android (Preview)
90a3ccdf-635c-4729-a248-9b709135078f Microsoft Authenticator for iOS (Preview)
c5703116-972b-4851-a3e7-ae1259843399 NEOWAVE Badgeo FIDO2
3789da91-f943-46bc-95c3-50ea2012f03a NEOWAVE Winkeo FIDO2
2cd2f727-f6ca-44da-8f48-5c2e5da000a2 Nitrokey 3 AM
b84e4048-15dc-4dd0-8640-f4f60813c8af NordPass
07a9f89c-6407-4594-9d56-621d5f1e358b NXP Semiconductros FIDO2 Conformance Testing CTAP2 Authenticator
0acf3011-bc60-f375-fb53-6f05f43154e0 Nymi FIDO2 Authenticator
a1f52be5-dfab-4364-b51c-2bd496b14a56 OCTATCO EzFinger2 FIDO2 AUTHENTICATOR
bc2fe499-0d8e-4ffe-96f3-94a82840cf8c OCTATCO EzQuant FIDO2 AUTHENTICATOR
69e7c36f-f2f6-9e0d-07a6-bcc243262e6b OneKey FIDO2 Authenticator
30b5035e-d297-4ff1-b00b-addc96ba6a98 OneSpan DIGIPASS FX1 BIO
30b5035e-d297-4ff1-010b-addc96ba6a98 OneSpan DIGIPASS FX1a
30b5035e-d297-4ff7-b00b-addc96ba6a98 OneSpan DIGIPASS FX7
30b5035e-d297-4fc1-b00b-addc96ba6a97 OneSpan FIDO Touch
998f358b-2dd2-4cbe-a43a-e8107438dfb3 OnlyKey Secp256R1 FIDO2 CTAP2 Authenticator
664d9f67-84a2-412a-9ff7-b4f7d8ee6d05 OpenSK authenticator
09591fc6-9811-48f7-8f57-b9f23df6413f Pone Biometrics OFFPAD Authenticator
69700f79-d1fb-472e-bd9b-a3a3b9a9eda0 Pone Biometrics OFFPAD Authenticator
88bbd2f0-342a-42e7-9729-dd158be5407a Precision InnaIT Key FIDO 2 Level 2 certified
50726f74-6f6e-5061-7373-50726f746f6e Proton Pass
59f85fe7-faa5-4c92-9f52-697b9d4d5473 RSA Authenticator 4 for Android
8681a073-5f50-4d52-bce4-e21658d207b3 RSA Authenticator 4 for iOS
7e3f3d30-3557-4442-bdae-139312178b39 RSA DS100
efb96b10-a9ee-4b6c-a4a9-d32125ccd4a4 Safenet eToken FIDO
74820b05-a6c9-40f9-8fb0-9f86aca93998 SafeNet eToken Fusion
23786452-f02d-4344-87ed-aaf703726881 SafeNet eToken Fusion CC
53414d53-554e-4700-0000-000000000000 Samsung Pass
b92c3f9a-c014-4056-887f-140a2501163b Security Key by Yubico
f8a011f3-8c0a-4d15-8006-17111f9edc7d Security Key by Yubico
149a2021-8ef6-4133-96b8-81f8d5b7f1f5 Security Key by Yubico with NFC
6d44ba9b-f6ec-2e49-b930-0c8fe920cb73 Security Key by Yubico with NFC
e77e3c64-05e3-428b-8824-0cbeb04b829d Security Key NFC by Yubico
a4e9fc6d-4cbe-4758-b8ba-37598bb5bbaa Security Key NFC by Yubico
47ab2fb4-66ac-4184-9ae1-86be814012d5 Security Key NFC by Yubico - Enterprise Edition
0bb43545-fd2c-4185-87dd-feb0b2916ace Security Key NFC by Yubico - Enterprise Edition
9ff4cc65-6154-4fff-ba09-9e2af7882ad2 Security Key NFC by Yubico - Enterprise Edition (Enterprise Profile)
2772ce93-eb4b-4090-8b73-330f48477d73 Security Key NFC by Yubico - Enterprise Edition Preview
760eda36-00aa-4d29-855b-4012a182cdeb Security Key NFC by Yubico Preview
89b19028-256b-4025-8872-255358d950e4 Sentry Enterprises CTAP2 Authenticator
891494da-2c90-4d31-a9cd-4eab0aed1309 Sésame
516d3969-5a57-5651-5958-4e7a49434167 SmartDisplayer BobeePass FIDO2 Authenticator
8876631b-d4a0-427f-5773-0ec71c9e0279 Solo Secp256R1 FIDO2 CTAP2 Authenticator
8976631b-d4a0-427f-5773-0ec71c9e0279 Solo Tap Secp256R1 FIDO2 CTAP2 Authenticator
9876631b-d4a0-427f-5773-0ec71c9e0279 Somu Secp256R1 FIDO2 CTAP2 Authenticator
931327dd-c89b-406c-a81e-ed7058ef36c6 Swissbit iShield Key FIDO2
5d629218-d3a5-11ed-afa1-0242ac120002 Swissbit iShield Key Pro
092277e5-8437-46b5-b911-ea64b294acb7 Taglio CTAP2.1 CS
7d2afadd-bf6b-44a2-a66b-e831fceb8eff Taglio CTAP2.1 EP
ab32f0c6-2239-afbb-c470-d2ef4e254db6 TEST (DUMMY RECORD)
8836336a-f590-0921-301d-46427531eee6 Thales Bio Android SDK
66a0ccb3-bd6a-191f-ee06-e375c50b9846 Thales Bio iOS SDK
4d41190c-7beb-4a84-8018-adf265a6352d Thales IDPrime FIDO Bio
cd69adb5-3c7a-deb9-3177-6800ea6cb72a Thales PIN Android SDK
17290f1e-c212-34d0-1423-365d729f09d9 Thales PIN iOS SDK
91ad6b93-264b-4987-8737-3a690cad6917 Token Ring FIDO2 Authenticator
ab32f0c6-2239-afbb-c470-d2ef4e254db7 TOKEN2 FIDO2 Security Key
eabb46cc-e241-80bf-ae9e-96fa6d2975cf TOKEN2 PIN Plus Security Key Series
cc45f64e-52a2-451b-831a-4edd8022a202 ToothPic Passkey Provider
95e4d58c-056e-4a65-866d-f5a69659e880 TruU Windows Authenticator
ba86dc56-635f-4141-aef6-00227b1b9af6 TruU Windows Authenticator
cfcb13a2-244f-4b36-9077-82b79d6a7de7 USB/NFC Passcode Authenticator
73402251-f2a8-4f03-873e-3cb6db604b03 uTrust FIDO2 Security Key
5626bed4-e756-430b-a7ff-ca78c8b12738 VALMIDO PRO FIDO
d94a29d9-52dd-4247-9c2d-8b818b610389 VeriMark Guard Fingerprint Key
99ed6c29-4573-4847-816d-78ad8f1c75ef VeroCard FIDO2 Authenticator
5fdb81b8-53f0-4967-a881-f5ec26fe4d18 VinCSS FIDO2 Authenticator
d7a423ad-3e19-4492-9200-78137dccc136 VivoKey Apex FIDO2
6028b017-b1d4-4c02-b4b3-afcdafc96bb2 Windows Hello
08987058-cadc-4b81-b6e1-30de50dcbe96 Windows Hello
9ddd1817-af5a-4672-a2b9-3e3dd95000a9 Windows Hello
f56f58b3-d711-4afc-ba7d-6ac05f88cb19 WinMagic FIDO Eazy - Phone
31c3f7ff-bf15-4327-83ec-9336abcbcd34 WinMagic FIDO Eazy - Software
970c8d9c-19d2-46af-aa32-3f448db49e35 WinMagic FIDO Eazy - TPM
504d7149-4e4c-3841-4555-55445a677357 WiSECURE AuthTron USB FIDO2 Authenticator
5753362b-4e6b-6345-7b2f-255438404c75 WiSECURE Blentity FIDO2 Authenticator
73bb0cd4-e502-49b8-9c6f-b59445bf720b YubiKey 5 FIPS Series
85203421-48f9-4355-9bc8-8a53846e5083 YubiKey 5 FIPS Series with Lightning
5b0e46ba-db02-44ac-b979-ca9b84f5e335 YubiKey 5 FIPS Series with Lightning Preview
c1f9a0bc-1dd2-404a-b27f-8e29047a43fd YubiKey 5 FIPS Series with NFC
62e54e98-c209-4df3-b692-de71bb6a8528 YubiKey 5 FIPS Series with NFC Preview
ee882879-721c-4913-9775-3dfcce97072a YubiKey 5 Series
19083c3d-8383-4b18-bc03-8f1c9ab2fd1b YubiKey 5 Series
cb69481e-8ff7-4039-93ec-0a2729a154a8 YubiKey 5 Series
20ac7a17-c814-4833-93fe-539f0d5e3389 YubiKey 5 Series (Enterprise Profile)
c5ef55ff-ad9a-4b9f-b580-adebafe026d0 YubiKey 5 Series with Lightning
a02167b9-ae71-4ac7-9a07-06432ebb6f1c YubiKey 5 Series with Lightning
b90e7dc1-316e-4fee-a25a-56a666a670fe YubiKey 5 Series with Lightning (Enterprise Profile)
3124e301-f14e-4e38-876d-fbeeb090e7bf YubiKey 5 Series with Lightning Preview
fa2b99dc-9e39-4257-8f92-4a30d23c4118 YubiKey 5 Series with NFC
a25342c0-3cdc-4414-8e46-f4807fca511c YubiKey 5 Series with NFC
2fc0579f-8113-47ea-b116-bb5a8db9202a YubiKey 5 Series with NFC
1ac71f64-468d-4fe0-bef1-0e5f2f551f18 YubiKey 5 Series with NFC (Enterprise Profile)
34f5766d-1536-4a24-9033-0e294e510fb0 YubiKey 5 Series with NFC Preview
dd86a2da-86a0-4cbe-b462-4bd31f57bc6f YubiKey Bio FIDO Edition
d8522d9f-575b-4866-88a9-ba99fa02f35b YubiKey Bio Series
7d1351a6-e097-4852-b8bf-c9ac5c9ce4a3 YubiKey Bio Series - Multi-protocol Edition
90636e1f-ef82-43bf-bdcf-5255f139d12f YubiKey Bio Series - Multi-protocol Edition
97e6a830-c952-4740-95fc-7c78dc97ce47 YubiKey Bio Series - Multi-protocol Edition (Enterprise Profile)
58276709-bb4b-4bb3-baf1-60eea99282a7 YubiKey Bio Series - Multi-protocol Edition 1VDJSN
83c47309-aabb-4108-8470-8be838b573cb YubiKey Bio Series (Enterprise Profile)
8c39ee86-7f9a-4a95-9ba3-f6b097e5c2ee YubiKey Bio Series (Enterprise Profile)
b35a26b2-8f6e-4697-ab1d-d44db4da28c6 Zoho Vault
99bf4610-ec26-4252-b31f-7380ccd59db5 ZTPass SmartAuth
```

## Keep up to date

* [Visit my blog](https://blog.darrenjrobinson.com)
* [Follow darrenjrobinson on Twitter](https://twitter.com/darrenjrobinson) ![](http://twitter.com/favicon.ico)
