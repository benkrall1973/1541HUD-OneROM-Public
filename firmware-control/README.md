# UB3 Control Builder Kit — V0.8.0

This directory contains the **compiled inputs** needed to compose a custom UB3
Control image with OneROM CLI. It does not compile source code; it assembles a
firmware image from the supplied patched V8 base, plugins, bootloader, and a
JSON manifest.

## Included

- `base-firmware/onerom-rp235x-1541HUD-v0.8.0-patched.bin` — the V8 Control
  base containing the required NV-write idle-yield integration.
- `plugins/` — compiled V0.8.0.15 1541HUD USB and Host-Control plugins.
- `bootloader/` — Universal bootloader V1.1.0.
- `configs/` — lower- and upper-socket examples with no JiffyDOS slot or
  commercial ROM input.
- `onerom-cli/onerom-v0.5.0.exe` — the verified Windows composition CLI.

## Build a UB3 lower-socket image

Open PowerShell at the **repository root** (the directory containing
`firmware-control/`) and run:

```powershell
.\firmware-control\onerom-cli\onerom-v0.5.0.exe firmware build `
  --config .\firmware-control\configs\1541HUD-Control-Lower-v0.8.0.17.example.json `
  --board fire-24-e `
  --base-firmware .\firmware-control\base-firmware\onerom-rp235x-1541HUD-v0.8.0-patched.bin `
  --output .\firmware-control\output\my-1541HUD-Control-Lower.bin `
  --force
```

The supplied example manifests intentionally use paths relative to the
**repository root**, because OneROM CLI resolves manifest file paths from the
current working directory.

Create `firmware-control/output` before running the command if the CLI does
not create it on the installed version.

### ROM-input integrity boundary

The default example manifests download Original DOS ROM files from the approved
Zimmers URLs recorded in [`ROM_SOURCES.md`](ROM_SOURCES.md). This keeps the
ordinary build path convenient, but those live URLs are not immutable build
inputs. For an offline/reproducible build, download the files, verify their
SHA-256 values in `ROM_SOURCES.md`, and use a private local copy of the
manifest with `firmware-control/rom-inputs/` paths. Keep those local inputs out
of version control.
A custom image is not release-qualified until its exact input provenance and
hardware result have been recorded.

The lower example is the relevant one for UB3 in the standard 1541HUD setup.
The upper example is supplied for custom hardware layouts; do not use it for
the normal UB3/UB4 arrangement.

## ROM inputs and licensing

No JiffyDOS or other private/commercial ROM image is included. The example
manifests use original-ROM URLs for their public fallback slots. Users who add
their own licensed ROMs must edit a copy of a manifest and keep those ROM files
out of version control.

Verify every distributed input against [SHA256SUMS.txt](SHA256SUMS.txt) before
composition. The final composed image is custom-user output and must be tested
before flashing hardware.

For the prebuilt Original-ROM-only candidate and the BOOTSEL flashing flow, see
[`../docs/FLASHING.md`](../docs/FLASHING.md). Hardware and USB sequencing are
defined in [`../docs/WIRING_AND_INSTALLATION.md`](../docs/WIRING_AND_INSTALLATION.md).
