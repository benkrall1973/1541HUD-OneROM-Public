# UB4 passive Monitor firmware — V0.8.0.15

`onerom-1541HUD-Monitor-Upper-v0.8.0.15-fire-24-e-rp2350.bin` is the complete
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

## Release status

This is the hardware-tested V0.8.0.15 Monitor assembly carried from the
private V8 release candidate. Public packaging and release notes are still in
progress; use only with the matching 1541HUD V8 Control/host release.
