# 1541HUD OneROM — Public Releases

## A project for the venerable 1541—if it trips your trigger

1541HUD is a OneROM community project for Commodore 1541 owners who want easier
ROM switching, USB control, and optional live drive-status monitoring. Begin
with the Windows interface, or configure your drive from the C64 after
installing one compatible UB3 OneROM board alongside your original drive ROM.
When you are ready, move to a compact Raspberry Pi touchscreen display mounted
on the drive.

Add capabilities at your own pace: multiple ROMs, programmable drive addresses,
write-protect control, and live telemetry for motor activity, full- and
half-track position, stepping, write status, disk density, headers, RPM, and
SYNC activity. The project also leaves room for many more community-developed
features, tools, displays, and integrations as ideas and hardware evolve.

### Recommended board for new builds

The **24 RGB Upright USB-C** is the recommended OneROM version to purchase for
new 1541HUD builds. Its upright USB-C connector makes the data cable much easier
to reach and connect after the board is installed in the drive.

Firmware, setup guides, and testing notes are available on GitHub for builders
and testers.

## Start here

1. Read [wiring and installation](docs/WIRING_AND_INSTALLATION.md) before
   opening the drive or connecting USB.
2. Confirm compatibility and ROM licensing in
   [Compatibility, Limitations, and ROM Licensing](docs/COMPATIBILITY_AND_LIMITATIONS.md).
3. Read the [hardware and use disclaimer](DISCLAIMER.md).
4. Verify the exact artifact using [SHA256SUMS.txt](SHA256SUMS.txt).
5. Read [release verification](docs/RELEASE_VERIFICATION.md) to understand what
   that checksum can and cannot prove.
6. Follow [flashing and recovery](docs/FLASHING.md) one board at a time.
7. Check the [support and qualification matrix](docs/SUPPORT_MATRIX.md) and
   the [FAQ](docs/FAQ.md) before choosing an artifact.
8. Install 1541HUD and/or the C64 configurator after firmware validation.

## About this public beta repository

This repository is the public distribution point for 1541HUD OneROM releases.
It intentionally contains distributable artifacts and user documentation, not
the private development tree. Each artifact has a stated qualification level;
do not treat every file as universally hardware-validated merely because it is
in a repository. That would be a spectacularly efficient way to confuse a
checksum with an engineering result.

### Release status and trust boundary

This is a **public beta package**, not an immutable signed release.
The included SHA-256 manifests verify that a downloaded file matches the file
recorded in this repository revision; they do **not** authenticate the publisher
or prove that a mutable branch has not changed. This package includes
unsigned 1541HUD Windows executables and firmware artifacts.

Use the package only for evaluation on hardware you are prepared to recover.
For a promoted release, obtain the artifact from a GitHub Release whose
protected tag and checksum manifest are signed, then follow
[release verification](docs/RELEASE_VERIFICATION.md). Until that exists, do
not treat it as a production distribution channel.

### What belongs here

- an UB3 Control composition candidate and a hardware-tested UB4 Monitor image;
- the Windows 1541HUD application release;
- C64 configurator release files;
- checksums, wiring, flashing, and installation documentation; and
- safe configuration examples that do not include private ROM files.

### What does not belong here

- private ROM inputs or licensed ROM images without redistribution rights;
- firmware source snapshots, private build environments, diagnostics, or
  experimental candidates; and
- internal patch-development notes.

This public-beta package is still being prepared for a promoted release. The
UB3 Control artifact is a candidate; do not treat it as flash-ready until it
has been hardware-qualified for the recipient installation. UB4 is limited to
the documented paired evaluation configuration and its wiring prerequisites.

## Optional control wiring

The UB3 ROM/USB Control function does **not** require the programmable IEC
address wiring or the write-protect override circuit. Those are independent,
optional installation features: leave the 1541's normal address straps in
place when programmable IEC addressing is not wanted, and omit the X2/GPIO8
transistor circuit when write-protect override is not wanted. X1 is separate:
it is required whenever UB3 must serve both halves of the 1541 ROM address
range.

## Installation photos

These photographs show the hardware-qualified development/test installation.
They are reference examples, not a substitute for the pinout and electrical
rules in the [wiring guide](docs/WIRING_AND_INSTALLATION.md). In particular,
the IC test clips are temporary validation tools; do not treat their placement
or wire colours as a universal 1541 wiring standard.

| Paired OneROM installation | Temporary IEC-selector verification |
| --- | --- |
| ![Two Fire-24E OneROM boards installed in the 1541 ROM area](docs/images/paired-oneroms-and-ic-clips.jpg) | ![Temporary IC clips used while verifying IEC selector wiring](docs/images/temporary-iec-selector-test-clips.jpg) |
| Two Fire-24E boards installed for the UB3 Control / UB4 Monitor paired layout. | Temporary test clips used to verify the IEC selector mapping before permanent modification. |

| Installed-board detail | Optional write-protect test circuit |
| --- | --- |
| ![Detailed view of paired Fire-24E OneROM boards in the 1541](docs/images/paired-oneroms-installed-detail.jpg) | ![Breadboarded NPN write-protect override test circuit](docs/images/write-protect-override-breadboard.jpg) |
| Detail view of the paired OneROM installation and temporary test leads. | Breadboard validation of the optional X2/GPIO8 write-protect override transistor circuit before permanent wiring. |

## Components

- `firmware-monitor/` contains the complete UB4 V0.8.0.14 passive Monitor
  image and its checksum. It is upper-socket-only and must be paired with a
  compatible UB3 Control installation.
- `firmware-control/` contains the UB3 custom-composition kit: patched V8
  base, compiled plugins, bootloader, verified CLI, and no-JiffyDOS example
  manifests.
- `c64-onerom-configurator/` contains the V0.8.0.01 C64 `.PRG` and `.d64`
  release files.
- `1541hud/` contains the portable Windows V0.8.0.14 application and its
  checksum.

## V0.8.0.14 RPM measurement

V0.8.0.14 adds passive, live RPM measurement while normal disk software is
running. It does not write a test sector, require a test disk, or add a spindle
sensor. After the Monitor sees a checksum-valid physical header, it uses that
header only to establish the standard density-zone geometry. It then timestamps
raw SYNC marks over two complete disk revolutions to calculate RPM.

The timer does not wait for the same header or sector to return. Standard 1541
geometry supplies the revolution boundary: 42, 38, 36, or 34 SYNC marks per
revolution for density zones 3 through 0 respectively. The measured RPM also
feeds the HUD's expected-SYNC, SYNC-per-revolution, density-validation, and
card-detail calculations.

During a seek or unreadable interval, V14 retains the last confirmed RPM rather
than showing an incomplete sample. When the motor stops, the RPM card shows
`--.--`. The method is intended for standard readable GCR tracks, including
many commercial disks with protection elsewhere. Deliberately nonstandard or
unreadable protection tracks may not produce enough valid evidence; the HUD
will hold the last confirmed value or report RPM as unavailable rather than
inventing a number.

## 1541HUD reference screenshots

These screenshots are from V0.8.0.13 and illustrate the core dashboard and
Control wiring reminders. The current distributable is V0.8.0.14; its RPM and
timing-card additions may make parts of the display differ. Verify the exact
HUD version from [RELEASE_MANIFEST.md](RELEASE_MANIFEST.md), not from a
screenshot.

The Windows HUD combines passive UB4 evidence with confirmed UB3 Control
operations. The Control-feature checkbox card visibly reminds the operator
that programmable IEC addressing requires SEL_A/SEL_B wiring and write-protect
override requires the optional X2/GPIO8 transistor circuit.

| Live dashboard | Protected idle state |
| --- | --- |
| ![Writing activity and enabled write-protect override](1541hud/images/v0.8.0.13/01-dashboard-writing-override.png) | ![Protected idle dashboard](1541hud/images/v0.8.0.13/02-dashboard-protected.png) |

| Control-feature wiring reminder | Control OneROM assignment |
| --- | --- |
| ![Control feature checkboxes with visible wiring reminder](1541hud/images/v0.8.0.13/03-settings-control-features.png) | ![Control OneROM setup](1541hud/images/v0.8.0.13/04-control-setup.png) |

| Activity log | Card configuration |
| --- | --- |
| ![OneROM activity and telemetry log](1541hud/images/v0.8.0.13/05-activity-log.png) | ![HUD card visibility and order configuration](1541hud/images/v0.8.0.13/06-card-configuration.png) |

| Appearance controls |
| --- |
| ![HUD appearance settings](1541hud/images/v0.8.0.13/07-appearance-menu.png) |

## C64 Configurator hardware validation

The C64 Configurator V0.8.0.01 was validated on real C64/1541 hardware for
drive discovery, dynamic ROM-slot listing, ROM startup selection, persistent
IEC-address changes, and temporary IEC-address use. The ROM labels in these
photos are from the test configuration; this public repository does not ship
licensed replacement ROM images. The full validation sequence is retained in
the [Configurator technical reference](c64-onerom-configurator/TECHNICAL_REFERENCE.md).

| Drive polling | OneROM service discovery |
| --- | --- |
| ![Drive polling finds IEC devices](c64-onerom-configurator/images/hardware-validation/01-drive-polling.jpg) | ![Configurator finds the Control OneROM in the lower socket](c64-onerom-configurator/images/hardware-validation/02-service-discovery.jpg) |

| ROM selection | IEC address entry |
| --- | --- |
| ![Dynamically discovered seven-slot ROM menu](c64-onerom-configurator/images/hardware-validation/03-rom-selection.jpg) | ![Boot address selection entry screen](c64-onerom-configurator/images/hardware-validation/05-address-entry.jpg) |

The full artifact inventory, exact target roles, and qualification status are
in [RELEASE_MANIFEST.md](RELEASE_MANIFEST.md).

Original project material is released under the [MIT License](LICENSE).
Release-package changes are tracked in [CHANGELOG.md](CHANGELOG.md).
