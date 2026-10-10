# 1541HUD Windows Technical Reference

1541HUD V0.8.0.13 is the Windows operator and diagnostic application for the
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
