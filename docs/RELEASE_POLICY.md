# Public release policy

Published artifacts must be checksum-recorded and must state their qualification
level: hardware-tested, composition-inspected candidate, or example input.

An evaluation branch is not a release. A promoted public release must use a
GitHub Release created from a signed, protected annotated tag. Its attached
checksum manifest must have a detached signature made by the release signing
key, and the public key fingerprint plus verification procedure must accompany
the release. If source cannot be public, the release notes must say so plainly
and must not claim reproducibility.

Each release must document the target board/socket, exact firmware filename,
SHA-256 checksum, flashing method, required host application version, and
known limitations. Do not publish JiffyDOS or other ROM images unless their
redistribution rights have been confirmed.

The private `1541HUD-OneROM-Private` repository remains the source of truth
for source code, patches, rebuild instructions, and engineering records.
