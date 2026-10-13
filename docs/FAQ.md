# Frequently asked questions

## What does “installation candidate” mean for UB3?

It means the UB3 V0.8.0.17 image is complete and checksum-recorded, but has not
been declared a universal hardware-validated baseline. It must be tested on the
recipient's documented Fire-24E lower-socket installation before relying on it.
See [SUPPORT_MATRIX.md](SUPPORT_MATRIX.md) for the exact boundary.

## Which flashing method should I use?

Use the CLI `program` command with the supplied `.bin` while the target OneROM
is running its normal USB firmware. Use BOOTSEL only for the matching `.uf2`
drag-and-drop alternative. Do not rename a BIN to UF2, and do not flash UB3
images to UB4 or the reverse. Follow [FLASHING.md](FLASHING.md).

## Why did an IEC or ROM setting not persist after restart?

UB3 must actually restart and reread its saved state. USB VBUS can keep the
board powered while the 1541 is switched off. Disconnect or block USB 5 V,
restart the 1541, then reconnect USB and read the setting back. “Data-only” is
not a reliable cable label; confirm that VBUS is absent.

## Which USB device is Control and which is Monitor?

Assign roles in 1541HUD by the stable OneROM USB serial number, not by the
Windows COM number. COM assignments may change after reconnecting devices.

## The Monitor causes a solid red LED or motor activity. What now?

Power down immediately. Check that the supplied UB4 passive Monitor image is
in the upper socket, UB3 remains lower Control, and the probe wiring matches a
reviewed record for that exact hardware. Do not “try another image” at random.

## Are the Original DOS ROM URLs safe to use?

They are approved convenience sources, not an immutable release input. The
default manifests use the listed Zimmers URLs. For an offline/reproducible
custom build, download the files, verify the recorded SHA-256 values in
[`../firmware-control/ROM_SOURCES.md`](../firmware-control/ROM_SOURCES.md),
and use local paths in a private manifest.

## Why is Windows warning about 1541HUD?

The HUD EXEs are not Authenticode-signed. Verify the exact SHA-256 listed in
the root manifest and use the program only within this public-beta scope. A
matching hash verifies file identity for this package; it is not publisher
authentication. See [RELEASE_VERIFICATION.md](RELEASE_VERIFICATION.md).

## Where is the source code?

It is intentionally private. This public repository distributes artifacts,
documentation, and configuration examples only. Source access is granted
separately at the maintainer's discretion.
