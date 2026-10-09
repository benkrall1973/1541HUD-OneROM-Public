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

The Control firmware supports a temporary write-protect override through the
existing UB3 installation. This release does not publish a universal soldering
pinout for that circuit: board and harness revisions differ. Do not connect a
OneROM GPIO directly to a 1541 logic node. Preserve the validated transistor
interface used by the installation, including its base resistor, and confirm
physical write-protect behavior after installation.

## Initial acceptance

1. Start the 1541 with UB3 installed; verify normal DOS operation.
2. Connect UB3 USB and confirm the Control device appears in 1541HUD.
3. Set a valid ROM slot and IEC address, read the confirmed reply, power-cycle
   the 1541 with UB3 USB VBUS absent, then confirm the values persist.
4. Install/connect UB4. Confirm no red LED/motor fault, then verify live
   Monitor activity in 1541HUD.
5. Test write-protect override physically, not only by observing a successful
   USB command response.
