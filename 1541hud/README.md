# 1541HUD V0.8.0.14 for Windows

`1541HUD-V0.8.0.14-win-x64.exe` is the portable Windows application for the
1541HUD monitor/control display. It communicates with the OneROM USB CDC
interfaces and supports the V0.8 settings and diagnostics workflow. V0.8.0.14
adds the tested raw-SYNC RPM display, timing-card calculation/help updates,
and aligned right-side motion indicators.

## How V14 measures RPM

RPM is measured passively while a disk is being used. The Monitor accepts a
checksum-valid physical header to identify the density zone, then timestamps
the raw SYNC pattern over two complete revolutions. The header is not used as a
"wait for this sector again" timer. The known number of SYNC marks in a normal
zone establishes each revolution boundary.

This avoids the old coarse one-second estimate and does not write a sector,
require a diagnostic disk, or disturb the running program. The confirmed
firmware RPM is also used by the expected-SYNC, SYNC-per-revolution,
density-validation, and related card-detail calculations. A seek or unreadable
interval holds the last confirmed RPM; motor-off displays `--.--`. Nonstandard
or unreadable protection tracks may leave RPM held or unavailable rather than
produce a false measurement.

The Control OneROM Features checkbox card includes a visible wiring reminder:
IEC-address control requires the optional SEL_A/SEL_B wiring, and write-protect
override requires the optional X2/GPIO8 transistor circuit.

## Use

1. Connect UB3 and, if fitted, UB4 by USB.
2. Run the executable. Allow Windows to enumerate the devices.
3. Assign the Control and Monitor by their OneROM serial numbers. Do not rely
   on a remembered COM number.
4. Use Refresh after a C64-side setting change. A successful action is shown
   only after a parsed Control reply; cold-reboot verification remains the
   final persistence check.

For hardware/socket placement and the USB power rule, read
[`../docs/WIRING_AND_INSTALLATION.md`](../docs/WIRING_AND_INSTALLATION.md).

The executable is self-contained and does not require a Python installation or
a separate Tcl/Tk runtime. On first run it creates its parameter/binding JSON
file if one is not already present. Keep that JSON file with the application
when preserving local device bindings.

Verify the executable against `SHA256SUMS.txt` before use.
