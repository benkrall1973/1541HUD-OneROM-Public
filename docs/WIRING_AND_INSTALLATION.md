# Wiring and Installation

## Supported V0.8 layout

This release supports the paired Fire-24E RP2350 OneROM installation below.

| Unit | Firmware role | 1541 socket | Bus role | USB role |
| --- | --- | --- | --- | --- |
| UB3 | Control | lower ROM socket | the only ROM-serving OneROM | Control CDC device |
| UB4 | Monitor | upper ROM socket | passive observer; never serves ROM data | Monitor CDC device |

Do not swap the boards. UB4 is only electrically passive when it is running
the supplied passive Monitor image; a normal ROM-serving V8 image in UB4 is
not interchangeable and can disrupt the drive.

## Choose the topology before wiring

There are two supported Control arrangements, depending on whether a Monitor
board is installed:

| Installed boards | UB3 Control placement | UB4 Monitor placement | Supported by this package |
| --- | --- | --- | --- |
| UB3 only | lower **or** upper ROM socket | none | yes; use the matching Control manifest and route X1 to the opposite socket pin 20 |
| UB3 + UB4 | lower ROM socket | upper ROM socket | yes; the standard paired 1541HUD arrangement |

Without UB4, UB3 can serve either ROM socket because the Control composition
has lower- and upper-socket examples. The only wiring change is X1: it must
reach pin 20 of the opposite ROM socket.

With UB4 installed, the topology is not interchangeable. UB3 must remain in
the lower socket because it is the ROM-serving Control board, and the supplied
UB4 V0.8.0.14 Monitor image must be installed in the upper socket. No
lower-socket Monitor image is distributed: it has no supported paired use case
in this release and has not been separately hardware-qualified. Do not move
the existing upper-socket Monitor image to the lower socket.

## Installation reference photos

The following are photographs of the qualified development/test installation.
They illustrate the physical context only; use the pin tables and electrical
rules below for actual connections. Temporary clip leads and the breadboard
are validation equipment, not permanent-installation instructions.

| Paired board placement | Temporary selector testing |
| --- | --- |
| ![Two Fire-24E OneROM boards installed in the 1541 ROM area](images/paired-oneroms-and-ic-clips.jpg) | ![Temporary IC clips used while verifying IEC selector wiring](images/temporary-iec-selector-test-clips.jpg) |
| UB3 Control and UB4 Monitor in the paired test installation. | IC clips used to validate IEC addressing before permanent work. |

| Board detail | Optional write-protect circuit validation |
| --- | --- |
| ![Detailed view of paired Fire-24E OneROM boards in the 1541](images/paired-oneroms-installed-detail.jpg) | ![Breadboarded NPN write-protect override test circuit](images/write-protect-override-breadboard.jpg) |
| Detail view of the installed OneROM boards and test leads. | Temporary breadboard validation of the optional WP override circuit. |

## Optional features: IEC addressing and write-protect override

The IEC-selector and write-protect-override connections are **optional**. UB3
still provides ROM service, USB configuration, ROM selection, and NV storage
without either circuit installed. They are not prerequisites for a basic UB3
or paired UB3/UB4 installation.

- Install `SEL_A`/`SEL_B` only when software-selectable IEC addresses 8–11 are
  desired. With these lines omitted, retain the 1541's original J1/J2 address
  straps and use the drive's existing fixed address.
- Install the X2/GPIO8 transistor circuit only when USB-controlled
  write-protect override is desired. Without it, `ROMWP` cannot alter the
  drive and the physical notch-sensor behavior remains normal.
- X1 is not part of either optional feature. It is the ROM-address extension
  required for UB3 to serve both ROM halves.

## Verified UB3 Control pinout

This table is the complete externally wired Control interface for the
documented 251748-style 1541 installation. Verify the PCB assembly and the IC
silkscreen before using it on another revision. The 1541 has enough board
variants that copying an IC designator from a different board is not an
installation procedure.

| Function | UB3 / Fire-24E endpoint | 1541 destination | Electrical rule |
| --- | --- | --- | --- |
| IEC selector A (bit 0) | GPIO25 / `SEL_A` | UC3 (6522) pin 15 | Drive LOW or release INPUT only; never drive HIGH. |
| IEC selector B (bit 1) | GPIO24 / `SEL_B` | UC3 (6522) pin 16 | Drive LOW or release INPUT only; never drive HIGH. |
| Upper/lower ROM select extension | X1 | pin 20 of the *other* 2364 ROM socket | Insulated fly-lead or removable Dupont lead; see socket table below. |
| Write-protect override control | X2 / GPIO8 | 5.1 kOhm resistor, then NPN base | Never connect X2 directly to a 1541 logic node. |
| Write-protect override pull-down | NPN collector | P6 pin 12 | The only 1541 WP node driven by UB3. |
| Write-protect override return | NPN emitter | 1541 ground | Common ground with the OneROM/drive. |

`SEL_A` and `SEL_B` are open-drain-style controls. LOW grounds the 1541
selector input; INPUT releases it to the drive pull-up. Their relationship to
the saved IEC address is:

| IEC address | GPIO25 / SEL_A / UC3-15 | GPIO24 / SEL_B / UC3-16 |
| --- | --- | --- |
| 8 | LOW | LOW |
| 9 | INPUT | LOW |
| 10 | LOW | INPUT |
| 11 | INPUT | INPUT |

The firmware never drives either selector HIGH. A swapped pair produces the
classic symptom where saved NV state looks correct but physical addresses 9
and 10 are reversed.

### IEC selector installation: test first, modify later

Skip this entire section if programmable IEC addressing is not required. Do
not cut straps or attach selector wiring merely because the firmware supports
the feature.

Do not begin by cutting traces on a working 1541. Early validation should use
insulated IC test clips on **UC3 pins 15 and 16** and a temporary ground/test
lead arrangement. Confirm that 1541HUD can select IEC 8, 9, 10, and 11 and
that the physical address agrees with the saved value before soldering any
permanent wiring.

For a reversible installation, use a suitable socket/interposer between UC3
and its permanent PCB socket that isolates the two selector pins (15 and 16)
from the board-side default straps, then route those isolated pins to SEL_A and
SEL_B. This allows the original 1541 to be restored without cutting PCB traces.
Do not alter unrelated UC3 pins; the rest of that 6522 is not decoration.

For a permanent installation, the board's IEC-address straps **J1/J2** may be
opened/cut only after the test-clip mapping has been confirmed. Opening both
straps without the OneROM selector wires connected leaves the selector inputs
released, so the drive will appear as IEC device **11**. That condition is
expected from the pull-up logic; it is not a firmware failure. Keep a clear
record of the original strap state and test the OneROM wiring before declaring
the conversion complete.

## X1 socket-routing table

X1 extends chip select to the second 8 KiB ROM half. It always lands on pin 20
of the **opposite** 2364 ROM socket. In the paired layout that socket is
occupied by UB4, but the destination remains the upper-socket pin-20 net:

| UB3 Control socket | UB3 serves directly | X1 must connect to |
| --- | --- | --- |
| Lower `$C000–$DFFF` socket | lower ROM half | pin 20 of the upper `$E000–$FFFF` socket |
| Upper `$E000–$FFFF` socket | upper ROM half | pin 20 of the lower `$C000–$DFFF` socket |

The shipped paired V0.8 firmware uses **only the first row**: UB3 lower and
UB4 Monitor upper. The upper-socket UB3 arrangement is a Control-only/custom
topology and cannot share the upper socket with UB4.

### Removable X1 connection

For a removable connection, with all power removed, solder a short header pin
to the exposed top of pin 20 on the OneROM installed in the opposite socket.
Run a female Dupont jumper from UB3 `X1` to that header pin. In the standard
paired layout, this is UB3 X1 to the top-side pin 20 of the upper-socket UB4
OneROM. Use insulated wire, strain relief, and continuity-check X1 to the
intended pin-20 net before power is applied. Do not bridge adjacent DIP pins.

## Before installation

1. Turn the 1541 off and disconnect mains power. Do not move ROMs or fly-leads
   on a powered drive.
2. Identify the actual 1541 PCB and mechanism revision. A 1541 is not one
   universal board with one universal monitor-probe pinout.
3. Photograph the original ROM/socket orientation and every existing OneROM
   connection. Confirm IC orientation and socket keying before removal.
4. Install UB3 only in the lower ROM socket and UB4 only in the upper ROM
   socket. Inspect for bent pins, lifted pads, bridges, and strained leads.
5. Do not connect UB4 probe leads unless you already possess a
   board/mechanism-specific, electrically reviewed wiring record for that exact
   installation. This public package does not publish a universal Monitor
   probe map. The passive Monitor firmware does not make an unknown probe lead
   safe. Verify every approved lead by continuity before powering the drive.

## USB and power rules

UB3 and UB4 enumerate as two separate USB CDC devices. Assign them in 1541HUD
by their OneROM USB serial numbers, not the Windows COM number; COM numbers
can change after reconnect.

For UB3, disconnect or block **USB VBUS (5 V)** when a 1541 power cycle must
make the board reread saved NV settings. "Data-only" is ambiguous in USB-cable
marketing, so do not rely on that label. USB 5 V can keep UB3 running while
the 1541 is restarted, so it does not perform its startup NV read. This is a
sequencing rule, not a claim that 5 V damages the board.

Before connecting USB to either board, confirm the 1541 starts normally with
the installed images. With UB4 connected, the drive must not show a solid red
LED, spin the motor, or otherwise change behavior merely because USB was
attached.

## Write-protect override wiring

This entire circuit is optional. Skip it if the drive should retain ordinary
physical write protection only; UB3 and UB4 continue to operate normally.

The Control firmware provides a volatile, USB-controlled write-protect
override. OFF leaves the physical disk-notch sensor in control; ON pulls the
sensor-side WP signal low so the drive appears writable. It is not a permanent
setting and returns OFF after an actual OneROM reset or power cycle.

```text
UB3 X2 / GPIO8 -- 5.1 kOhm -- base      KSC2383YTA NPN
1541 ground ---------------- emitter
1541 P6 pin 12 -------------- collector
```

### Write-protect BOM

| Qty | Part | Requirement / purpose |
| --- | --- | --- |
| 1 | KSC2383YTA | NPN transistor used as the low-side WP pull-down. |
| 1 | 5.1 kOhm resistor | Series base resistor; 1/8 W or 1/4 W is suitable. |
| 3 | insulated hookup wires | X2-to-resistor, collector-to-P6-12, and emitter-to-ground. |
| as needed | heat-shrink / insulation | Prevent shorts and lead fatigue. |

Verify the base/collector/emitter orientation against the exact physical
KSC2383YTA package and its datasheet before soldering. Do not infer the lead
order from a generic transistor drawing. The validated circuit has **no**
base-to-emitter pull-down; do not add one without electrical review and new
qualification.

Never connect X2 directly to P6 pin 12 or UC2 pin 14. UC2 pin 14 remains
observation-only and is not a UB3 output.

| Command state | GPIO8 / transistor | P6 pin 12 | Expected result |
| --- | --- | --- | --- |
| `ROMWP=OFF` | LOW / off | physical notch sensor controls node | normal write protection |
| `ROMWP=ON` | HIGH / on | pulled LOW | drive appears writable |

Validate with a protected disk: confirm normal protection, enable override,
meter P6 pin 12 low, confirm the independent observation point changes as
expected, disable override, and confirm physical sensor control returns. Use a
sacrificial disk for any actual write test.

## Monitor probe leads

The UB4 firmware captures motor, phase/step, write-protect, write-gate,
density, header, RPM, and SYNC evidence. Its probe-lead destinations are not
a universal 1541 pin table: they depend on PCB assembly, mechanism, harness,
and installed monitor hardware. Consequently, this public package is not a
complete UB4 probe-installation guide and the Monitor is only supported where
a board/mechanism-specific wiring record has already been reviewed. Do not
guess at probe locations from photographs. Record each actual UB4 pad/signal
label, IC designator and pin, continuity result, idle voltage, and active
polarity before installation.

## Initial acceptance

1. Start the 1541 with UB3 installed; verify normal DOS operation.
2. Connect UB3 USB and confirm the Control device appears in 1541HUD.
3. Set a valid ROM slot and read the confirmed reply. If the optional IEC
   selector wiring is installed, also select an IEC address and confirm the
   physical address. Power-cycle the 1541 with UB3 USB VBUS absent, then
   confirm the applicable values persist.
4. Install/connect UB4. Confirm no red LED/motor fault, then verify live
   Monitor activity in 1541HUD.
5. If the optional write-protect circuit is installed, test it physically, not
   only by observing a successful USB command response.
