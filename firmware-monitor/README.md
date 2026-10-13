# UB4 passive Monitor firmware - V0.8.0.14

`onerom-1541HUD-Monitor-Upper-v0.8.0.14-fire-24-e-rp2350.bin` is the complete
1541HUD UB4 Monitor image for a Fire-24E RP2350 OneROM.

## Hardware role

- Install this image only on **UB4**, in the **upper 1541 ROM socket**.
- UB4 is a passive monitor. It does not serve the 1541 ROM bus.
- A compatible UB3 Control OneROM must remain installed in the lower socket
  for normal 1541 operation.
- Do not flash this image to UB3 or use it as a standalone 1541 ROM image.

The image already contains the V8 passive monitor base, Monitor plugin, and
Monitor USB plugin. Users do not need the CLI, plugin binaries, ROM inputs, or
composition JSON to flash it.

## Integrity

Verify the file against [SHA256SUMS.txt](SHA256SUMS.txt) before flashing.

Flashing and post-flash checks are documented in
[`../docs/FLASHING.md`](../docs/FLASHING.md). Socket placement and USB-power
rules are in [`../docs/WIRING_AND_INSTALLATION.md`](../docs/WIRING_AND_INSTALLATION.md).

## Release status

This is the hardware-tested V0.8.0.14 Monitor assembly. It uses raw hardware
SYNC timing across two complete revolutions for stable RPM, holds the last
confirmed RPM through a head seek, and clears it when motor telemetry turns
off. Use it with the matching 1541HUD V0.8.0.14 host release.

The RPM feature is passive: it operates while ordinary disk software is
running and does not write to the disk, require a test disk, or use an external
sensor. A checksum-valid header supplies the density zone; the firmware then
counts and times raw SYNC marks, rather than waiting for one particular sector
header to repeat. Standard readable GCR tracks are supported. A deliberately
nonstandard or unreadable protection track can leave RPM held or unavailable,
which is preferable to publishing a false speed.
