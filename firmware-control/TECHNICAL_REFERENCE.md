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

`ROMLIST` is the authoritative ROM inventory. A compatible V0.8.0.14 HUD or
C64 Configurator requests the list and then reads individual `ROMSLOT` records
to show only the slots in the installed UB3 image. An original-ROM-only image
therefore reports one selectable ROM; the software must not invent extra slots
from an old fixed menu.

The patched V8 base includes a narrow capture-idle yield integration so the USB
plugin can enter exclusive flash mode for NV writes. Stock V8 plus the plugins
is not an equivalent Control assembly for this use case.

## IEC and write-protect behavior

The Host-Control plugin maps the saved IEC address using GPIO25/`SEL_A` and
GPIO24/`SEL_B` as open-drain-style LOW or INPUT states. It must never drive
those selector lines HIGH. The valid mapping is 8 = LOW/LOW, 9 = INPUT/LOW,
10 = LOW/INPUT, and 11 = INPUT/INPUT. An invalid value defaults electrically
to address 8. This is an optional feature: without the selector wires, retain
the 1541's fixed J1/J2 strap address and treat `ROMIEC` as saved state only,
not a physical-address change.

For a saved IEC address to take effect, UB3 must perform a genuine cold start
and reread NV2. USB VBUS can keep UB3 powered when the 1541 is switched off,
so use a data-only USB cable or remove/cut the USB 5 V path to UB3 if the
installation requires a cold-reboot address change. This is a startup-state
requirement, not a claim that USB 5 V damages the board.

Write-protect override is an optional hardware function coupled to the
installation's validated transistor interface. If its X2/GPIO8 transistor
circuit is not installed, omit `ROMWP` testing and retain normal physical
notch-sensor protection. If installed, `ROMWP=ON` or `ROMWP=OFF` is only a
Control request; acceptance requires physical behavior verification at the
drive.

## Custom composition

The CLI resolves paths in the JSON manifest from the current working directory.
Run the documented command from the repository root. Custom images must retain
the patched base and matching supplied plugin binaries. Add only ROM inputs
that you are allowed to possess and use, then inspect and hardware-test the
result before flashing.
