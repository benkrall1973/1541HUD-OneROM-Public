# Compatibility, Limitations, and ROM Licensing

## Supported configuration

This package targets a Fire-24E RP2350 paired-OneROM 1541 installation:
UB3 Control in the lower ROM socket and UB4 passive Monitor in the upper ROM
socket. It is designed as a coupled V0.8 system with 1541HUD V0.8.0.13.

UB3 provides ROM service, ROM selection, boot IEC address, persistent NV
state, and write-protect override. UB4 provides passive telemetry only. The
V0.8 Monitor image uses OneROM standby plus a local passive-core integration;
standby alone is not sufficient for this Monitor.

Programmable IEC addressing and write-protect override are optional hardware
features. A normal fixed-address, physical-write-protect 1541 installation may
omit both wiring circuits while retaining UB3 ROM/USB operation and, where
installed, UB4 monitoring.

## Important limitations

- This release supports Fire-24E RP2350 hardware only. Do not flash it to a
  different OneROM model without a separately qualified image.
- The published Original-ROM-only UB3 image has passed composition/inspection,
  but is a recipient-installation candidate rather than a universal
  hardware-qualified baseline. Test it before relying on it.
- The UB4 V0.8.0.07 Monitor assembly was hardware-tested in the paired
  installation. Monitor probe wiring remains hardware-specific and must be
  validated on each 1541 board/mechanism.
- Control persistence depends on the V8 idle-yield integration in the supplied
  patched Control base. Replacing that base with stock V8 can cause NV writes
  to stall or be rejected.
- UB3 USB VBUS must be absent during a 1541 restart that is intended to reread
  saved IEC/ROM startup state.
- The software displays confirmed Control replies and Monitor telemetry; it
  cannot prove a physical wiring change from a successful serial write alone.

## ROM and licensing rules

No JiffyDOS, commercial ROM, or other restricted ROM image is included here.
The provided Control examples reference publicly available Original Commodore
DOS ROM inputs only. You are responsible for obtaining and using any additional
ROM image under its applicable license.

Do not commit or redistribute licensed ROM binaries, private configuration
files, USB serial bindings, or local hardware logs. Keep custom manifests and
ROM inputs outside the release repository unless redistribution rights are
clear.
