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
UB4 V0.8.0.15 Monitor image must be installed in the upper socket. No
lower-socket Monitor image is distributed: it has no supported paired use case
in this release and has not been separately hardware-qualified. Do not move
the existing upper-socket Monitor image to the lower socket.

## Verified UB3 Control pinout

This table is the complete externally wired Control interface for the
documented 251748-style 1541 installation. Verify the PCB assembly and the IC
silkscreen before using it on another revision. The 1541 has enough board
variants that copying an IC designator from a different board is not an
installation procedure.

| Function | UB3 / Fire-24E endpoint | 1541 destination | Electrical rule |
| --- | --- | --- | --- |
| IEC selector A (bit 0) | GPIO24 / `SEL_A` | UC1 (6522) pin 15 | Drive LOW or release INPUT only; never drive HIGH. |
| IEC selector B (bit 1) | GPIO25 / `SEL_B` | UC1 (6522) pin 16 | Drive LOW or release INPUT only; never drive HIGH. |
| Upper/lower ROM select extension | X1 | pin 20 of the *other* 2364 ROM socket | One insulated fly-lead; see socket table below. |
| Write-protect override control | X2 / GPIO8 | 5.1 kΩ resistor, then NPN base | Never connect X2 directly to a 1541 logic node. |
| Write-protect override pull-down | NPN collector | P6 pin 12 | The only 1541 WP node driven by UB3. |
| Write-protect override return | NPN emitter | 1541 ground | Common ground with the OneROM/drive. |

`SEL_A` and `SEL_B` are open-drain-style controls. LOW grounds the 1541
selector input; INPUT releases it to the drive pull-up. Their relationship to
the saved IEC address is:

| IEC address | GPIO24 / SEL_A / UC1-15 | GPIO25 / SEL_B / UC1-16 |
| --- | --- | --- |
| 8 | LOW | LOW |
| 9 | INPUT | LOW |
| 10 | LOW | INPUT |
| 11 | INPUT | INPUT |

The firmware never drives either selector HIGH. A swapped pair produces the
classic symptom where saved NV state looks correct but physical addresses 9
and 10 are reversed.

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

## Before installation

1. Turn the 1541 off and disconnect mains power. Do not move ROMs or fly-leads
   on a powered drive.
2. Identify the actual 1541 PCB and mechanism revision. A 1541 is not one
   universal board with one universal monitor-probe pinout.
3. Photograph the original ROM/socket orientation and every existing OneROM
   connection. Confirm IC orientation and socket keying before removal.
4. Install UB3 only in the lower ROM socket and UB4 only in the upper ROM
   socket. Inspect for bent pins, lifted pads, bridges, and strained leads.
5. Use the documented monitor wiring for your specific UB4 hardware revision.
   The passive Monitor firmware does not magically make an unknown probe lead
   safe. Verify every lead by continuity before powering the drive.

## USB and power rules

UB3 and UB4 enumerate as two separate USB CDC devices. Assign them in 1541HUD
by their OneROM USB serial numbers, not the Windows COM number; COM numbers
can change after reconnect.

For UB3, use a data-only USB connection when a 1541 power cycle must make the
board reread saved NV settings. USB 5 V can keep UB3 running while the 1541 is
restarted, so it does not perform its startup NV read. This is a sequencing
rule, not a claim that 5 V damages the board.

Before connecting USB to either board, confirm the 1541 starts normally with
the installed images. With UB4 connected, the drive must not show a solid red
LED, spin the motor, or otherwise change behavior merely because USB was
attached.

## Write-protect override wiring

The Control firmware provides a volatile, USB-controlled write-protect
override. OFF leaves the physical disk-notch sensor in control; ON pulls the
sensor-side WP signal low so the drive appears writable. It is not a permanent
setting and returns OFF after an actual OneROM reset or power cycle.

```text
UB3 X2 / GPIO8 ── 5.1 kΩ ── base  KSC2383YTA NPN
1541 ground ───────────────── emitter
1541 P6 pin 12 ────────────── collector
```

### Write-protect BOM

| Qty | Part | Requirement / purpose |
| --- | --- | --- |
| 1 | KSC2383YTA | NPN transistor used as the low-side WP pull-down. |
| 1 | 5.1 kΩ resistor | Series base resistor; 1/8 W or 1/4 W is suitable. |
| 3 | insulated hookup wires | X2-to-resistor, collector-to-P6-12, and emitter-to-ground. |
| as needed | heat-shrink / insulation | Prevent shorts and lead fatigue. |

Verify the base/collector/emitter orientation against the exact physical
KSC2383YTA package and its datasheet before soldering. Do not infer the lead
order from a generic transistor drawing. The validated circuit has **no**
base-to-emitter pull-down; do not add one without electrical review and new
qualification.

Never connect X2 directly to P6 pin 12, UC2 pin 14, or a TrackDuino A3 lead.
TrackDuino A3 / UC2 pin 14 remains observation-only and is not a UB3 output.

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
and installed monitor hardware. This release intentionally does not invent
those destinations. Record each actual UB4 pad/signal label, IC designator and
pin, continuity result, idle voltage, and active polarity before installation.

## Initial acceptance

1. Start the 1541 with UB3 installed; verify normal DOS operation.
2. Connect UB3 USB and confirm the Control device appears in 1541HUD.
3. Set a valid ROM slot and IEC address, read the confirmed reply, power-cycle
   the 1541 with UB3 USB VBUS absent, then confirm the values persist.
4. Install/connect UB4. Confirm no red LED/motor fault, then verify live
   Monitor activity in 1541HUD.
5. Test write-protect override physically, not only by observing a successful
   USB command response.
