# Limited public beta testing

## Scope

This package is a limited beta for the documented Fire-24E RP2350 paired
installation: UB3 Control in the lower 1541 ROM socket and UB4 Monitor in the
upper ROM socket. Read the [release manifest](../RELEASE_MANIFEST.md),
[wiring guide](WIRING_AND_INSTALLATION.md), and [flashing and recovery guide](FLASHING.md)
before using any artifact.

UB3 V0.8.0.17 Control and UB4 V0.8.0.08 Monitor are hardware-tested for their
respective lower- and upper-socket roles in that paired installation. 1541HUD
V0.8.0.13 and C64 Configurator V0.8.0.01 are released application artifacts.
Their limitations and required wiring remain in the linked guides.

## UB3 Control release scope

`onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin`
is the hardware-tested, Original-ROM-only UB3 lower-socket Control image for
this beta. It must not be flashed to passive UB4, a different OneROM model, or
used as evidence that a different 1541 board/mechanism layout is safe.

## Safe testing boundaries

- Do not install or move boards with the 1541 powered.
- Verify SHA-256 before flashing and use only the exact documented board role
  and socket position.
- Preserve a known-working image and recovery path before testing.
- Stop immediately if connecting USB causes a solid red LED, motor activity,
  unexpected drive behaviour, or a failure to enumerate.
- Do not share licensed replacement ROM images or private ROM dumps in bug
  reports.

## What to include in a report

Report the OneROM serial number, exact artifact filename and SHA-256, board
role/socket, 1541 board/mechanism revision, Windows version, and a concise
reproduction sequence. Include screenshots or logs where useful, but remove
private ROM contents and serially sensitive material before sharing publicly.
