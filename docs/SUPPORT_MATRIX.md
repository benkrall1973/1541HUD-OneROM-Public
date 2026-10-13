# Support and qualification matrix

This table states what this public-beta package supports. A blank assumption is
not a compatibility promise.

| Component | Exact artifact/version | Supported role | Qualification | Do not use it for |
| --- | --- | --- | --- | --- |
| UB3 Control | V0.8.0.17 Original-ROM-only | Fire-24E RP2350, lower 1541 ROM socket | Composition-inspected installation candidate | Other OneROM models, upper socket in a paired setup, or an untested 1541 installation |
| UB4 Monitor | V0.8.0.14 | Fire-24E RP2350, upper 1541 ROM socket, paired with UB3 lower Control | Hardware-tested paired Monitor assembly | Standalone ROM service, UB3, another socket, or an installation without reviewed probe wiring |
| 1541HUD | V0.8.0.14 Windows x64 | USB CDC operator/diagnostic application | Tested portable application | Proving physical wiring or persistence without the documented readback/cold-reboot test |
| C64 Configurator | V0.8.0.01 | Compatible UB3 V0.8 Control installation | Release artifact | Replacing Control firmware or installing ROM images |

## Candidate means test before reliance

The UB3 V0.8.0.17 file is an **installation candidate**. It is a complete,
checksum-recorded image that has passed composition/inspection, but this public
package does not claim it has been hardware-qualified on every recipient's
drive. It is not known-bad and it is not a placeholder; it simply has not
earned the stronger claim “validated baseline.”

Before relying on it, use the documented lower-socket Fire-24E layout, retain a
known-good recovery image, verify normal drive operation, verify ROM selection,
and perform the VBUS-free cold-reboot persistence test. If those checks pass on
your specific drive, record the board/mechanism revision and result.

## Out of scope

- Any OneROM model other than Fire-24E RP2350.
- Swapping UB3 and UB4 roles or socket positions.
- A universal UB4 probe-wiring map: wiring must be reviewed for the specific
  1541 PCB, mechanism, harness, and installed Monitor hardware.
- An unsigned branch download treated as a signed production release.
