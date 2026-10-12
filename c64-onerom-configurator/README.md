# C64 OneROM Configurator V0.8.0.01

Release files for configuring OneROM settings from a Commodore 64.

## Files

- `C64-OneROM-Configurator-V0.8.0.01.PRG` — load and run from a disk image or supported transfer tool.
- `C64-OneROM-Configurator-V0.8.0.01.d64` — disk image containing the configurator.

The V0.8.0.01 release preserves the established quit paths and the temporary
IEC-address workflow. It writes the supported persistent settings through the
OneROM protocol; it does not contain private or licensed ROM images.

This rebuild removes only the unintended blank row above the title on the
initial drive-poll screen.

## Use

Load the `.PRG` through your normal C64 transfer method, or mount the `.d64`
using your normal disk-image workflow. Choose a ROM slot or IEC address, then
confirm the value after a cold reboot of the 1541. For the UB3 startup read to
occur, USB 5 V/VBUS must not keep UB3 powered during that reboot: unplug UB3
USB, use a data-only cable, or use a dedicated cable with only its red 5 V
conductor interrupted.

The configurator requires a compatible UB3 V0.8 Control image. It is not a
standalone replacement for the Control firmware.

Verify downloads against `SHA256SUMS.txt` before use.
