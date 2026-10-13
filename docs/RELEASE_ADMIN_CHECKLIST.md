# Release administration checklist

This checklist covers GitHub settings and cryptographic operations that cannot
be enforced by repository files alone. Do not mark a public-beta snapshot as a
promoted release until every applicable item is complete.

## GitHub repository settings

- Protect `main` and the release branch: require pull requests and block force
  pushes and branch deletion.
- The current repository ruleset does not require the `Release verification`
  check because GitHub did not match its reported pull-request check name to
  the selected ruleset context. Until that context is successfully validated
  on a live pull request, treat a successful `Release verification` Actions
  run as a mandatory manual merge gate. Do not add a status-check requirement
  merely because its displayed label looks similar.
- When a required status-check context has been validated on a live pull
  request, enable it in the ruleset and re-test the protected merge path.
- Restrict who can bypass branch protections and who can create protected tags.
- Create a GitHub Release from the reviewed, signed tag; do not distribute a
  mutable branch URL as the promoted artifact location.

## Artifact authentication

- Create an annotated, cryptographically signed tag for the exact release
  commit.
- Sign the release `SHA256SUMS.txt` manifest with the release signing key.
- Publish the detached manifest signature, public key, and verified key
  fingerprint in the GitHub Release.
- Record every artifact's qualification level, board role, socket position,
  and hardware-test result in the release notes.

## Engineering gates

- Re-run `tools/verify-release.ps1` on the final commit.
- Hardware-test the exact UB3 and UB4 binaries on each claimed configuration;
  do not promote composition-only candidates.
- Attach or reference the electrically reviewed, board/mechanism-specific UB4
  probe-wiring record for every configuration claimed as supported.
- If a reproducible public build is not available, say so in the release notes
  and do not claim independent binary reproducibility.
