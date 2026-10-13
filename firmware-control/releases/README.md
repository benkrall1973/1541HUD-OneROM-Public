# UB3 composed firmware images

## V0.8.0.17 Original-ROM-only Control candidate

`onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin`
is a complete UB3 lower-socket Control image composed from the public builder
kit. It contains the patched V8 Control base, V0.8.0.15 USB and Host-Control
plugins, the OneROM bootloader, and two selectable ROM slots:

1. OneROM bootloader
2. Original 1541 DOS ROM

It contains **no JiffyDOS ROM image or JiffyDOS slot**.

`onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.uf2`
contains the identical complete image in the RP2350 BOOTSEL drag-and-drop
format. Use the `.bin` with OneROM CLI during normal USB operation; use the
`.uf2` only after intentionally putting **UB3** into BOOTSEL mode. Do not
rename the `.bin` to `.uf2`; a BIN file is not accepted by the BOOTSEL loader.

| Field | Value |
| --- | --- |
| Board | Fire-24E RP2350 |
| Role | UB3 Control, lower 1541 ROM socket |
| BIN SHA-256 | `8C4F9429A378F990838FFB8CF0A90B27E4C902891C6CCDB5BD67644C36B81080` |
| UF2 SHA-256 | `4C2793E6CEEA7791D893B3E6084D554A130701771466186B426980B2C3102C42` |
| CLI composition check | V8.0, both 1541HUD plugins, two ROM slots verified |

This is a newly composed public candidate. The shared base and plugins are from
the hardware-tested private V0.8.0.17 Control assembly, but this exact
Original-ROM-only composition must be hardware-tested before being promoted to
a validated public release.

Flash it only to **UB3 in the lower socket**. Do not flash it to passive UB4.
