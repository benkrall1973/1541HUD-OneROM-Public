# Limited public beta testing

## Scope

This package is a limited beta for the documented Fire-24E RP2350 paired
installation: UB3 Control in the lower 1541 ROM socket and UB4 Monitor in the
upper ROM socket. Read the [release manifest](../RELEASE_MANIFEST.md),
[wiring guide](WIRING_AND_INSTALLATION.md), and [flashing and recovery guide](FLASHING.md)
before using any artifact.

The UB4 V0.8.0.08 Monitor image is hardware-tested for that upper-socket role.
1541HUD V0.8.0.13 and C64 Configurator V0.8.0.01 are released application
artifacts. Their limitations and required wiring remain in the linked guides.

## Do not flash the public UB3 candidate

`onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin`
is composition-inspected, not hardware-qualified. It is included for review
and future controlled qualification; it is **not** a general beta flashing
baseline. Do not use it on a tester's drive until the project publishes a
hardware-qualified Control release for that exact image.

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
