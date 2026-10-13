# Release Verification and Provenance

## Current package: evaluation only

This public-beta package is distributed from mutable branches. Its `SHA256SUMS.txt` file
is useful for detecting a damaged or incomplete download, but a checksum stored
beside a binary does not authenticate who supplied either file. The package does
not currently publish signed tags, detached checksum signatures, attestations,
or a reproducible public build.

The Windows 1541HUD executables are not Authenticode-signed. Windows warnings
are therefore expected; do not bypass them merely because a filename looks
familiar. The included `onerom-v0.5.0.exe` is separately Authenticode-signed by
its publisher, but that does not authenticate the firmware or HUD artifacts in
this repository.

Do not use this package as a production firmware distribution channel. Use it
only for controlled evaluation with a recovery plan and a sacrificial disk.

## Verifying a promoted release

A promoted release is acceptable only when all of the following exist on its
GitHub Release page:

1. An annotated, cryptographically signed tag naming the exact commit.
2. Release assets, including `SHA256SUMS.txt` and a detached signature for it.
3. The release signing-key fingerprint and a published public key.
4. A qualification statement for each artifact and, where source is private, a
   clear statement that independent reproduction is unavailable.

After independently obtaining the publisher's public key and checking its
fingerprint through a second channel, verify the detached checksum signature.
Then verify the desired file locally:

```powershell
Get-FileHash -Algorithm SHA256 .\path\to\artifact
```

Compare that result with the signed manifest entry for the exact path. Finally,
confirm the board type, socket role, version coupling, and qualification level.
A correct hash cannot make a wrong image safe for the hardware in front of you.

## Custom Control builds

The default Control manifests download ROM inputs from the approved Zimmers
URLs listed in `firmware-control/ROM_SOURCES.md`. The automated release check
allows only those exact HTTPS locations. For a reproducible custom build,
download the inputs first, verify their SHA-256 values, use local paths in a
private manifest, and hardware-test the result before flashing. A custom
output is not equivalent to a promoted release.
