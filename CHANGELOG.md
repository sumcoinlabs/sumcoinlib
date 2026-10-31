# Changelog

## 0.0.3 — 2026-10-31


#### v0.0.3 validation follow-up (test fixtures)
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
