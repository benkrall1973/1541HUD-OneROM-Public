# Approved Original DOS ROM sources

The default Control example manifests use the following public Zimmers archive
URLs. They are approved for convenience only; a live URL is not a substitute
for verifying bytes before an offline or reproducible build.

| File | Approved URL | Size | SHA-256 snapshot |
| --- | --- | ---: | --- |
| `1541-c000.325302-01.bin` | `https://www.zimmers.net/anonftp/pub/cbm/firmware/drives/new/1541/1541-c000.325302-01.bin` | 8192 bytes | `6FA7B07AFF92DA66B0A28A52BB3C82FFE310AB0FAD2CC473B40137A8D299C7E5` |
| `1541-e000.901229-05.bin` | `https://www.zimmers.net/anonftp/pub/cbm/firmware/drives/new/1541/1541-e000.901229-05.bin` | 8192 bytes | `F973FE75AA79EFC863A2F24E3BF7A90DBA802A2049A32283182C2924A3D45935` |

These SHA-256 values were recorded on 2026-10-13 from the listed URLs. To use
the strict local-input path, download the files yourself, run
`Get-FileHash -Algorithm SHA256`, compare the result with this table, and place
the matching files in `firmware-control/rom-inputs/`. Do not silently accept a
changed upstream file: investigate it and update this record only after review.
