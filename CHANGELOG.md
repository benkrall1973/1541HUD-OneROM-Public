# Changelog

This changelog tracks public-package releases. Engineering experiments and
private-repository history are intentionally not duplicated here.

## Unreleased — V0.8 public beta package

### Included

- UB4 passive Monitor V0.8.0.14 for Fire-24E RP2350, upper 1541 ROM socket.
- UB3 Control builder kit with patched V8 base, V0.8.0.15 USB/Host-Control
  plugins, bootloader, CLI, and safe lower/upper configuration examples.
- UB3 V0.8.0.17 Original-ROM-only lower-socket composition candidate.
- 1541HUD Windows x64 V0.8.0.14 portable executable.
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
- Documented V0.8.0.14 passive RPM measurement: a valid header establishes
  density geometry, then raw SYNC marks are timed over two complete
  revolutions. The method runs during normal disk use and requires neither a
  test disk nor disk writes.
- Documented RPM behavior on seeks, unreadable media, and intentionally
  nonstandard protection tracks, plus the related SYNC/density card
  calculations.
- Corrected the UB4 CLI flashing filename to V0.8.0.14 and corrected the UB3
  custom-build command paths.
- Documented the unsigned/mutable-branch trust boundary, upstream-ROM input
  boundary, release-signing requirement, and the lack of a universal UB4 probe
  installation map.
- Corrected the CLI BIN flashing workflow to use normal USB mode; BOOTSEL is
  now reserved for the UF2 drag-and-drop alternative.
- Replaced live ROM URLs with private local-input paths and added automated
  checksum, obsolete-filename, and remote-ROM-input verification.

### Known qualification boundary

- UB4 V0.8.0.14 was hardware-tested in the paired upper-socket Monitor role.
- The public UB3 Original-ROM-only V0.8.0.17 composition is checksum-verified
  and CLI-inspected, but remains a hardware-test candidate until it is tested
  on the target installation.
