# Changelog

This changelog tracks public-package releases. Engineering experiments and
private-repository history are intentionally not duplicated here.

## Unreleased — V0.8 public beta package

### Included

- UB4 passive Monitor V0.8.0.07 for Fire-24E RP2350, upper 1541 ROM socket.
- UB3 Control builder kit with patched V8 base, V0.8.0.15 USB/Host-Control
  plugins, bootloader, CLI, and safe lower/upper configuration examples.
- UB3 V0.8.0.17 Original-ROM-only lower-socket composition candidate.
- 1541HUD Windows x64 V0.8.0.13 portable executable.
- C64 OneROM Configurator V0.8.0.01 as `.PRG` and `.d64`.

### Documentation

- Added wiring, socket, USB-power, X1, IEC-selector, and write-protect
  override guidance.
- Clarified that programmable IEC addressing and write-protect override are
  optional circuits, not prerequisites for UB3 ROM/USB or UB4 Monitor use.
- Added flashing/recovery procedure, release manifest, checksums,
  compatibility limitations, ROM licensing rules, and component technical
  references.
- Added V0.8.0.13 HUD screenshots and a visible Control-feature wiring
  reminder for optional IEC selector and write-protect override hardware.

### Known qualification boundary

- UB4 V0.8.0.07 was hardware-tested in the paired upper-socket Monitor role.
- The public UB3 Original-ROM-only V0.8.0.17 composition is checksum-verified
  and CLI-inspected, but remains a hardware-test candidate until it is tested
  on the target installation.
