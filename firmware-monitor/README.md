# UB4 passive Monitor firmware - V0.8.0.07

`onerom-1541HUD-Monitor-Upper-v0.8.0.07-fire-24-e-rp2350.bin` is the complete
1541HUD UB4 Monitor image for a Fire-24E RP2350 OneROM.

`onerom-1541HUD-Monitor-Upper-v0.8.0.07-fire-24-e-rp2350.uf2` packages that
same qualified image for RP2350 BOOTSEL drag-and-drop flashing. Use either
file, not both: the UF2 is a transport wrapper around the exact released BIN
payload.

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

Verify the chosen file against [SHA256SUMS.txt](SHA256SUMS.txt) before
flashing. For BOOTSEL, copy the `.uf2` file to the mounted RP2350 drive; for
CLI flashing, use the `.bin` file.

Flashing and post-flash checks are documented in
[`../docs/FLASHING.md`](../docs/FLASHING.md). Socket placement and USB-power
rules are in [`../docs/WIRING_AND_INSTALLATION.md`](../docs/WIRING_AND_INSTALLATION.md).

## Release status

This is the current hardware-tested V0.8.0.07 Monitor assembly. It was
flashed to UB4 and verified with USB enumeration, 1541HUD connection, and
live Monitor telemetry. Use it only with the matching 1541HUD V8 Control/host
release.
