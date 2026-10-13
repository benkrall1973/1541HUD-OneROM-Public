# Private ROM inputs required for custom Control builds

The example manifests expect these locally supplied files:

- `1541-c000.325302-01.bin`
- `1541-e000.901229-05.bin`

They are intentionally not included in this repository. Obtain only ROM inputs
you are entitled to use, verify their SHA-256 values against a source you
trust, and retain a private provenance record. The `.bin` files in this folder
are ignored by Git so they cannot be committed accidentally.

Do not replace these names with an HTTP/HTTPS URL in a release manifest.
