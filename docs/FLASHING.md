# Flashing and Recovery

## Safety rules

Flash one OneROM at a time. Close 1541HUD, terminal programs, and anything
else holding its COM port before flashing. Identify the physical board and its
USB serial; a remembered COM number is not board identity.

Use the supplied raw `.bin` files only with OneROM CLI's `program` command.
Do not drag a `.bin` onto a BOOTSEL mass-storage volume or rename it to `.uf2`.

## Flash UB3 Control

The bundled `firmware-control/releases/` image is the hardware-tested
Original-ROM-only Control assembly for the documented Fire-24E lower-socket
role. It is not validated for different board models, socket roles, or 1541
board/mechanism variants.

1. Disconnect UB4 USB and power down the 1541 where practical.
2. Put UB3 into BOOTSEL mode and connect it to the computer.
3. From repository root, verify the image hash in `SHA256SUMS.txt`.
4. Program and verify:

   ```powershell
   .\firmware-control\onerom-cli\onerom-v0.5.0.exe program `
     --firmware .\firmware-control\releases\onerom-1541HUD-Control-Lower-v0.8.0.17-original-only-fire-24-e-rp2350.bin `
     --verify --scan-slots
   ```

5. Reconnect normally. Confirm ROM listing, a valid ROM/IEC save, and a
   cold-reboot readback. During that reboot, UB3 must receive no USB 5 V/VBUS:
   unplug it, use a data-only cable, or use a dedicated cable with only its
   red 5 V conductor interrupted.

To create a custom Control image, follow `firmware-control/README.md` and use
only ROMs you are authorized to use.

## Flash UB4 Monitor

1. Put UB4 into BOOTSEL mode; UB3 is not the target.
2. Verify the Monitor image hash.
3. From repository root, program and verify:

   ```powershell
   .\firmware-control\onerom-cli\onerom-v0.5.0.exe program `
     --firmware .\firmware-monitor\onerom-1541HUD-Monitor-Upper-v0.8.0.08-fire-24-e-rp2350.bin `
     --verify --scan-slots
   ```

4. Install UB4 in the upper socket and connect USB. The red LED must remain
   off and the motor must not run merely because USB is present.
5. Connect 1541HUD and verify live telemetry during real drive activity.

## Recovery

- **`Access is denied` / port busy:** close the program that owns the port;
  flashing does not cure a serial-handle conflict.
- **UB3 causes abnormal drive behavior:** power down, inspect socket seating
  and control wiring, and restore a known-good UB3 image.
- **UB4 lights the red LED or spins the motor:** power down immediately. Verify
  that UB4 received the supplied passive Monitor image and is in the upper
  socket; do not replace it with a normal Control image.
- **Monitor is blank:** first collect the Monitor `STATUS`/`DIAG` information
  in 1541HUD and inspect physical probe wiring before reflashing.
