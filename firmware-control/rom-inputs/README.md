# Private ROM inputs required for custom Control builds

For an offline/reproducible copy of an example manifest, use these locally
supplied files:

- `1541-c000.325302-01.bin`
- `1541-e000.901229-05.bin`

They are intentionally not included in this repository. The default manifests
use the approved Zimmers URLs for convenience; see
[`../ROM_SOURCES.md`](../ROM_SOURCES.md) for the URL and SHA-256 snapshot
values. The `.bin` files in this folder are ignored by Git so they cannot be
committed accidentally.

Use these paths only after checking the downloaded files against the recorded
SHA-256 values. A release manifest may use only the approved URLs listed in
`ROM_SOURCES.md`.
