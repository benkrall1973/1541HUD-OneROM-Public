# 1541HUD Windows Technical Reference

1541HUD V0.8.0.14 is the Windows operator and diagnostic application for the
paired UB3/UB4 system. It is not firmware and does not itself own drive state.
It displays confirmed replies from UB3 Control and physical telemetry from UB4
Monitor.

The application discovers separate CDC devices and stores role bindings in its
parameter JSON. Assign Control and Monitor by stable OneROM USB serial number,
not Windows COM port. A COM number is an endpoint that Windows may reassign.

Control operations use request → firmware reply → readback → reboot verification.
The ROM picker is built from `ROMLIST` metadata supplied by the Control image;
it must not assume a fixed number of slots. Monitor connection/reset clears
stale observation state so old motor, header, RPM, or SYNC evidence is not
shown as new hardware data.

The portable executable creates a default parameter/binding JSON when absent.
Keep that JSON with the deployment when preserving device role assignments and
preferences. If a port is busy, exit any other terminal, diagnostic tool, or
HUD instance before reconnecting.

V0.8.0.13 adds a visible wiring reminder to the Control OneROM Features
checkbox card: IEC-address control requires SEL_A/SEL_B wiring, while
write-protect override requires the optional X2/GPIO8 transistor circuit.

## V0.8.0.14 rotation and card calculations

V0.8.0.14 uses the Monitor firmware's `RPM` record as the primary spindle
reading. The Monitor first needs a checksum-valid physical header to identify
the disk-density zone, then times raw SYNC edges across two complete
revolutions. This avoids the coarse count-window rounding that made a drive
appear to jump between an exact nominal RPM and a visibly different value.

During a seek, step sequence, or unreadable interval, the firmware holds the
last confirmed RPM instead of publishing a partial timing window. When the
motor stops, the RPM field clears to `--.--`. SYNC rate, SYNC/revolution,
header rate, capture rate, sector coverage, density, and disk identity remain
useful diagnostic cards, but they never overwrite the measured RPM.

The application processes every complete telemetry record. It may limit Canvas
redraw frequency while the Monitor is producing high-rate traffic so USB
Control actions remain responsive; this does not discard physical telemetry.

## Control discovery and Pi use

On a Control connection, 1541HUD sends `ROMLIST` and then `ROMSLOT=<n>`
requests to build the ROM picker from the installed UB3 image. It does not
guess how many ROMs exist from a fixed menu. UB3 is therefore required for ROM
selection, IEC settings, and write-protect override. UB4 alone can provide
passive cards and RPM but cannot report the actual UB3 ROM inventory.

The same V0.8.0.14 application can run on a Raspberry Pi touchscreen. For a
complete Pi console, connect both boards with data-capable USB cables and bind
them by stable OneROM serial number. Restart a running HUD after updating it;
an autostart entry affects the next launch and cannot reload an already-running
Python process.
