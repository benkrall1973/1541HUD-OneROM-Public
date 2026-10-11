# 1541HUD OneROM Public Release Manifest

## V0.8 package

| Component | Version | Target | Status | Artifact |
| --- | --- | --- | --- | --- |
| UB3 Control | V0.8.0.17 | Fire-24E; lower socket | Original-ROM-only candidate; composition inspected | `firmware-control/releases/onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin` |
| UB4 Monitor | V0.8.0.07 | Fire-24E; upper socket | hardware-tested paired Monitor assembly | `firmware-monitor/onerom-1541HUD-Monitor-Upper-v0.8.0.07-fire-24-e-rp2350.bin` |
| Windows 1541HUD | V0.8.0.13 | Windows x64 | tested portable application | `1541hud/1541HUD-V0.8.0.13-win-x64.exe` |
| C64 configurator | V0.8.0.01 | Commodore 64 | release artifact | `c64-onerom-configurator/C64-OneROM-Configurator-V0.8.0.01.PRG` and `.d64` |

The V0.8 system is a paired release: UB3 is lower-socket active Control and
UB4 is upper-socket passive Monitor. Do not combine these roles with other
socket placements or generic OneROM images without a separately qualified
build.

## Integrity and verification

`SHA256SUMS.txt` at repository root is the package checksum manifest. Each
component directory also carries a smaller checksum file for its local
artifacts. It covers byte-for-byte distributable binaries and binary build
inputs. The JSON example manifests are Git-tracked source text and are not
included because a normal Windows Git checkout may rewrite their line endings.
On Windows, verify an artifact with:

```powershell
Get-FileHash -Algorithm SHA256 .\path\to\artifact
```

Compare the displayed hash with the exact path in `SHA256SUMS.txt`. A checksum
proves file identity, not that a file is appropriate for the board/socket in
front of you.

## Release boundaries

This repository contains distributable artifacts, safe configuration examples,
and operating documentation. It intentionally excludes private source history,
licensed ROM images, device bindings, diagnostics, and engineering experiments.
The private engineering repository remains the rebuild and patch record.

Read `docs/WIRING_AND_INSTALLATION.md`, `docs/FLASHING.md`, and
`docs/COMPATIBILITY_AND_LIMITATIONS.md` before powering or flashing hardware.
