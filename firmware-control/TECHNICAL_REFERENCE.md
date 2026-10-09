# UB3 Control Technical Reference

## Role and image contract

UB3 is the active Control OneROM installed in the lower 1541 ROM socket. It is
the only board in this package that serves ROM data. The supplied builder kit
contains compiled V0.8 inputs, not source compilation machinery: patched V8
base, Universal bootloader, USB plugin, Host-Control plugin, CLI, and example
composition manifests.

The included original-only image is composed for Fire-24E RP2350 hardware. It
contains a bootloader plus an Original DOS slot. The default persistent state
is NV0 = slot 1 and NV2 = IEC device 8 when valid state has not yet been saved.

## Persistent state and protocol

| Storage | Meaning | Normal writer |
| --- | --- | --- |
| NV0 | startup ROM slot | `ROMSET=<slot>` |
| NV1 | reserved | none |
| NV2 | boot IEC address, 8–11 | `ROMIEC=<address>` |

The Control endpoint supplies `ROMLIST` for image-defined slot metadata,
`ROMGET` for saved state, `ROMSET`, `ROMIEC`, and `ROMWP` commands. A host must
wait for and parse the firmware reply, then read back and cold-reboot verify;
serial transmission alone does not establish persistence.

The patched V8 base includes a narrow capture-idle yield integration so the USB
plugin can enter exclusive flash mode for NV writes. Stock V8 plus the plugins
is not an equivalent Control assembly for this use case.

## IEC and write-protect behavior

The Host-Control plugin maps the saved IEC address using GPIO24/GPIO25 as
open-drain-style LOW or INPUT states. It must never drive those selector lines
HIGH. The valid mapping is 8 = LOW/LOW, 9 = INPUT/LOW, 10 = LOW/INPUT, and
11 = INPUT/INPUT. An invalid value defaults electrically to address 8.

Write-protect override is a hardware function coupled to the installation's
validated transistor interface. `ROMWP=ON` or `ROMWP=OFF` is only a Control
request; acceptance requires physical behavior verification at the drive.

## Custom composition

The CLI resolves paths in the JSON manifest from the current working directory.
Run the documented command from the repository root. Custom images must retain
the patched base and matching supplied plugin binaries. Add only ROM inputs
that you are allowed to possess and use, then inspect and hardware-test the
result before flashing.
