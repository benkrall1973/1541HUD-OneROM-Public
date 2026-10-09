# 1541HUD OneROM — Public Releases

This repository is the public distribution point for validated 1541HUD OneROM
releases. It intentionally contains release-ready user artifacts and concise
documentation, not the private development tree.

## What belongs here

- validated UB3 Control and UB4 Monitor firmware images;
- the Windows 1541HUD application release;
- C64 configurator release files;
- checksums, wiring, flashing, and installation documentation; and
- safe configuration examples that do not include private ROM files.

## What does not belong here

- private ROM inputs or licensed ROM images without redistribution rights;
- firmware source snapshots, private build environments, diagnostics, or
  experimental candidates; and
- internal patch-development notes.

The first public release is being assembled. Until a release is marked
validated, do not treat any artifact in this repository as flash-ready.

## Current staging artifacts

- `firmware-monitor/` contains the complete UB4 V0.8.0.15 passive Monitor
  image and its checksum. It is upper-socket-only and must be paired with a
  compatible UB3 Control installation.
- `firmware-control/` contains the UB3 custom-composition kit: patched V8
  base, compiled plugins, bootloader, verified CLI, and no-JiffyDOS example
  manifests.
- `c64-onerom-configurator/` contains the V0.8.0.01 C64 `.PRG` and `.d64`
  release files.
- `1541hud/` contains the portable Windows V0.8.0.12 application and its
  checksum.
