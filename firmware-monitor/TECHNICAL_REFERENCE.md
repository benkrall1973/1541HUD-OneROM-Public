# UB4 Monitor Technical Reference

## Role and passive-core requirement

UB4 is the passive Monitor OneROM installed in the upper 1541 ROM socket. It
does not serve ROM data, select a ROM, change IEC address, or own Control NV
state. Its dedicated USB CDC endpoint publishes Monitor telemetry to 1541HUD.

The supplied V0.8.0.14 image contains both V8 standby configuration and the
required passive-core profile. The passive profile prevents generic ROM-serving
PIO/DMA startup, leaving bus GPIOs as inputs. This is required to avoid the
previous USB-connected failure mode: red LED, motor spin, and corrupted 1541
operation. Do not substitute a normal Control image or a stock V8 base.

## Capture transport

The Monitor captures drive evidence into a circular mailbox and the Monitor
USB component exposes it through the separate CDC device. 1541HUD consumes
normal `STATUS` telemetry and diagnostic records of the form:

```text
DIAG P=<pio_pc> X=<rx_level> B=<dma_busy> N=<dma_trans_count>
```

When the HUD is blank, preserve `STATUS` and `DIAG` output first. Those records
separate missing physical activity from capture setup faults; reflashing at
random is not diagnosis.

## V0.8.0.14 RPM measurement

The V0.8.0.14 Monitor image measures rotation from raw hardware SYNC timing,
not from a coarse once-per-second count. A checksum-valid physical header
establishes the density zone; the firmware then measures two complete
revolutions and emits the resulting `RPM` record. The paired V0.8.0.14 HUD
uses this record as its primary spindle value.

The firmware rejects incomplete timing windows. It retains the last confirmed
RPM while the head is stepping or the disk cannot provide a usable header, and
clears RPM when motor telemetry reports OFF. SYNC count/rate, header activity,
capture rate, and density are retained as supporting diagnostics rather than
being allowed to manufacture a replacement RPM value.

This behavior was exercised with normal disk reads and 1541 Diagnostic Cart
and Zibri speed tests. Track changes can momentarily retain the prior confirmed
value; that is intentional protection against a bad partial sample.

## Coupling and limits

UB4 must be treated as coupled to the supplied UB3/1541HUD V0.8 release. It
was tested in the upper socket with UB3 lower Control. Its monitor probe leads
are specific to the target 1541 board and mechanism and are not defined by the
firmware image alone. Verify continuity, idle voltage, and active polarity on
the actual installation before adding or moving a lead.

For the released host/firmware pair, use 1541HUD V0.8.0.14 with the
V0.8.0.14 UB4 image. Use a data-capable USB cable; a charge-only cable cannot
carry the Monitor CDC telemetry.
