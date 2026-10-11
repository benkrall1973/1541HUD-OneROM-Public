# UB3 composed firmware images

## V0.8.0.17 Original-ROM-only Control release

`onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin`
is a complete UB3 lower-socket Control image composed from the public builder
kit. It contains the patched V8 Control base, V0.8.0.15 USB and Host-Control
plugins, the OneROM bootloader, and two selectable ROM slots:

1. OneROM bootloader
2. Original 1541 DOS ROM

It contains **no JiffyDOS ROM image or JiffyDOS slot**.

| Field | Value |
| --- | --- |
| Board | Fire-24E RP2350 |
| Role | UB3 Control, lower 1541 ROM socket |
| SHA-256 | `8C4F9429A378F990838FFB8CF0A90B27E4C902891C6CCDB5BD67644C36B81080` |
| CLI composition check | V8.0, both 1541HUD plugins, two ROM slots verified |

This exact Original-ROM-only composition was flashed with verification and
hardware-tested in the documented paired Fire-24E installation. The validation
scope is UB3 in the lower ROM socket; it does not qualify a different OneROM
model, socket role, or 1541 board/mechanism variant.

Flash it only to **UB3 in the lower socket**. Do not flash it to passive UB4.
