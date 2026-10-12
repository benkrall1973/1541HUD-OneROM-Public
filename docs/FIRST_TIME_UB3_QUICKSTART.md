# First-Time UB3 Quick Start

Use this path for the first successful installation. It deliberately proves
the ROM-serving and ROM-selection functions before adding the Monitor or any
optional control wiring.

## Supported starting hardware

This release is qualified only for a **Fire-24E RP2350 OneROM**. No newer or
other OneROM model is supported or qualified by this release unless a
separately published image explicitly says so.

Start with **one** Fire-24E board:

| Board | Role | Socket | Required external connection |
| --- | --- | --- | --- |
| UB3 | Control | lower `$C000-$DFFF` ROM socket | X1 to pin 20 of the upper `$E000-$FFFF` ROM socket |

Do **not** install UB4 for this first test. Do **not** install `SEL_A`,
`SEL_B`, or the X2/GPIO8 write-protect override circuit. Leave the 1541's
normal IEC-address straps in their original fixed-address configuration.

X1 is the exception: UB3 needs it to serve both halves of the 1541 ROM. See
the [X1 socket-routing table](WIRING_AND_INSTALLATION.md#x1-socket-routing-table)
for the exact destination and the removable-connection guidance.

## First success: known-good ROM service

1. With the 1541 unplugged from mains power, photograph the original ROM
   orientation and identify the lower and upper ROM sockets. Do not move boards
   or wiring while powered.
2. Install the Fire-24E board as **UB3 Control in the lower socket** and make
   the X1 connection to the upper-socket pin-20 net. Do not install UB4 yet.
3. Verify the SHA-256 hash of
   `firmware-control/releases/onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin`.
4. Flash that prebuilt UB3 image using the [UB3 flashing procedure](FLASHING.md#flash-ub3-control).
   It is the documented Fire-24E lower-socket Control image and contains two
   selectable ROM choices: the OneROM bootloader and Original 1541 DOS.
5. Power the drive normally and confirm that it behaves as a normal 1541.
   Stop and power down if it shows a solid red LED, spins unexpectedly, or
   behaves abnormally.

## Prove ROM selection and persistence

1. Connect only UB3 USB and assign it as the Control device in 1541HUD, or
   load the C64 Configurator. UB4 is not needed for this test.
2. Read the ROM list and select a valid ROM choice. Confirm that the tool shows
   a parsed, successful Control reply.
3. Disconnect UB3 USB so USB VBUS cannot keep the board powered. Cold-reboot
   the 1541 and then reconnect USB.
4. Read the selected startup ROM again and confirm that it persisted and that
   the drive still operates normally.

Do not treat a successful USB command alone as proof of persistence; the cold
reboot check is the proof. Once this works, make a copy of a builder manifest
and add only ROM images you are licensed to use.

## Add features one at a time

After the UB3-only ROM-selection test succeeds:

1. Build and test a custom multi-ROM UB3 image if needed.
2. Add UB4 in the upper socket only if passive telemetry is wanted; use the
   supplied Monitor image and its hardware-specific probe validation.
3. Add `SEL_A`/`SEL_B` only if software-selectable IEC addresses are wanted.
4. Add the X2/GPIO8 transistor circuit only if USB-controlled write-protect
   override is wanted.

For every step, keep a known-working image and validate the new function before
moving to the next one. The existing installation photos remain reference
examples for the qualified paired installation; they are not a requirement for
this single-UB3 quick start.
