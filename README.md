# 1541HUD OneROM — Public Releases

This repository is the public distribution point for 1541HUD OneROM releases.
It intentionally contains distributable artifacts and user documentation, not
the private development tree. Each artifact has a stated qualification level;
do not treat every file as universally hardware-validated merely because it is
in a repository. That would be a spectacularly efficient way to confuse a
checksum with an engineering result.

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

## Start here

1. Read [wiring and installation](docs/WIRING_AND_INSTALLATION.md) before
   opening the drive or connecting USB.
2. Confirm compatibility and ROM licensing in
   [Compatibility, Limitations, and ROM Licensing](docs/COMPATIBILITY_AND_LIMITATIONS.md).
3. Read the [hardware and use disclaimer](DISCLAIMER.md).
4. Verify the exact artifact using [SHA256SUMS.txt](SHA256SUMS.txt).
5. Follow [flashing and recovery](docs/FLASHING.md) one board at a time.
6. Install 1541HUD and/or the C64 configurator after firmware validation.

## Optional control wiring

The UB3 ROM/USB Control function does **not** require the programmable IEC
address wiring or the write-protect override circuit. Those are independent,
optional installation features: leave the 1541's normal address straps in
place when programmable IEC addressing is not wanted, and omit the X2/GPIO8
transistor circuit when write-protect override is not wanted. X1 is separate:
it is required whenever UB3 must serve both halves of the 1541 ROM address
range.

## Components

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

The full artifact inventory, exact target roles, and qualification status are
in [RELEASE_MANIFEST.md](RELEASE_MANIFEST.md).

Original project material is released under the [MIT License](LICENSE).
Release-package changes are tracked in [CHANGELOG.md](CHANGELOG.md).
