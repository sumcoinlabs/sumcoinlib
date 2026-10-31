# Changelog

## v0.0.3 — October 31, 2026

**The short version:** v0.0.3 makes the existing Sumcoin Dart/Flutter library
more accurate, easier to test, and independently branded. Normal mainnet
wallet addresses and default seed derivation have not changed.

### What did not change

- **Mainnet:** WIF 187, P2PKH 63, P2SH 125, extended public `F588B21F`,
  extended private `F588ADE5`, and Bech32 prefix `sum`.
- **Wallet recovery:** BIP32 still uses `Bitcoin seed` by default. This string
  is part of the established derivation standard, not Bitcoin branding.
- **Normal transactions:** Version 3 is still the default; its encoding still
  omits the legacy transaction timestamp field.
- **Public imports:** `package:sumcoinlib/sumcoinlib.dart` and
  `package:sumcoinlib_flutter/sumcoinlib_flutter.dart` are unchanged.
- **Cryptography:** The secp256k1 algorithm/library was not replaced.

### Improvements

- Correct Sumcoin testnet address/key prefixes; introduce `Network.regtest`.
- Read, write, and preserve the `nTime` field for transaction versions 1 and 2.
- Make the optional `HDPrivateKey.fromSeed(..., key: ...)` argument work.
- Correct inherited test fixtures, including Bech32 addresses, extended keys,
  WIF, signatures, and transaction hash cases.
- Clean up Flutter example assets, package versions, CI paths, and documentation.

### What existing applications need to know

| Feature | v0.0.2 | v0.0.3 | Action |
|---|---|---|---|
| Mainnet wallet key/address prefixes | Existing Sumcoin values | **Same** | No mainnet prefix migration |
| Default BIP32 seed derivation | Standard `Bitcoin seed` | **Same** | No change to default recovery |
| `Network.testnet` | Incorrect inherited values | Sumcoin Core values | Check testnet wallets/fixtures |
| Manual v1/v2 transaction creation | No timestamp required | `time:` required | Supply correct Unix timestamp |
| Default v3 transactions | No `nTime` | **Same** | No intended encoding changes |
| Explicit custom BIP32 `key:` | Silently ignored | Honored | Custom-key results will differ |

**v0.0.3 is not strictly free of breaking behavior.** The testnet and legacy
transaction fixes are intentional corrections. See [MIGRATION.md](MIGRATION.md).

### Verification and limits

The local Mac run reported **289 passing Dart/Chrome tests, zero failures**.
Flutter plugin and example static analyzers found no issues. A source comparison
found only six changed Dart runtime files, itemized in [VALIDATION.md](VALIDATION.md).
Full native-platform builds and independent live Sumcoin Core integrations
are **not yet confirmed**.

### README/docs follow-up on `master` (after the v0.0.3 tag)

- Updated all three READMEs to use the [official Sumcoin logo](https://sumcoin.org/wp-content/uploads/2019/07/sumcoin_400x400.png).
- Added source-version, license, Dart, Flutter, and live CI-workflow badges.
- Expanded this changelog and the verification report in plain English.
- Removed the unused placeholder SVG; **no runtime code changed**.
- Preserved the existing `v0.0.3` release tag.

### Technical release notes for v0.0.3

#### Test-fixture corrections
- Correct deterministic Base58Check test addresses from inherited byte prefixes to Sumcoin Core mainnet P2PKH=63 and P2SH=125. No source-code prefix values or hash160 payloads changed.
- Re-encode standardized BIP32 test keys using Sumcoin's extended-private/public key version bytes while retaining all original BIP32 key material, chain codes and derivation checks.
- Re-encode the test-only WIF key with Sumcoin's prefix 187; regenerate expected ECDSA compact message signatures against `Sumcoin Signed Message:\n` using deterministic RFC6979/secp256k1.
- Adapt the synthetic BIP341 nine-input signing fixture to Sumcoin transaction v3 (no legacy timestamp) and independently recalculate eight expected TapSighash vectors. The independent calculator matched the eight original reference hashes before adaptation.
- Resolve new release-test lint warnings; keep normal analyzer information separate from test failures.
- These changes affect test fixtures, not existing wallet keys, addresses, transaction hashes or consensus parameters.

### Compatibility and correctness
- Align testnet and regtest address and extended-key encodings with Sumcoin Core.
- Add `nTime` parsing, serialization, and preservation for transaction versions
  below 3; enforce explicit timestamps in manually constructed legacy txs.
- Preserve the legacy transaction timestamp in legacy signature preimages.
- Make `HDPrivateKey.fromSeed(..., key: ...)` honor its documented optional key;
  the standard `Bitcoin seed` default remains unchanged.
- Replace legacy upstream Bech32 test expectations with `sum1` checksummed
  address vectors; add network and legacy transaction regression tests.

### Branding, development, and documentation
- Replace inherited project name, README, logo and demo app icons with Sumcoinlib.
- Repair CI paths and test setup; add Dart + Flutter CI checks.
- Normalize package versions to 0.0.3 and correct local example dependencies.
- Rename leftover native/demo identifiers and fix CocoaPods version metadata.
- Remove stale example and CocoaPods lockfiles that pinned superseded packages;
  ignore regenerated example lockfiles.
- Document change rationale, installation, migration, provenance and QA gates.

### Limits
- This release does not activate witness or Taproot consensus support.
- Native platform builds and Sumcoin Core integration tests must pass separately.
- License notices and standards-mandated cryptographic identifiers are retained.

## v0.0.2

Previous Sumcoin release; see the [Dart](sumcoinlib/CHANGELOG.md) and [Flutter](sumcoinlib_flutter/CHANGELOG.md) package histories.

## v0.0.1

Initial Sumcoin release.
