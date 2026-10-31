# Sumcoinlib 0.0.3 migration and compatibility guide

## Existing code

Both packages remain named `sumcoinlib` and `sumcoinlib_flutter`; the primary
Dart import is `package:sumcoinlib/sumcoinlib.dart`. The public `Network.mainnet`
parameters and standard `HDPrivateKey.fromSeed(seed)` derivation are unchanged.

## Testnet and regtest correction

**Breaking correction for applications that previously used `Network.testnet`:**
the old testnet config had inherited prefixes, including Bech32 `tpc`.
`Network.testnet` now matches Sumcoin Core: address prefixes 64/126, WIF 188,
HD public/private `F488B21F/F488ADE5`, and Bech32 `tsum`.

`Network.regtest` is new and uses `sumr` for Bech32. Do not reinterpret or
migrate existing private keys by simply changing their displayed text; compare
against Sumcoin Core and verify wallets using known seed/address fixtures.

## Transaction versions 1 and 2

Sumcoin Core writes `nTime` for versions below 3. Version 3 omits `nTime`.
In 0.0.3, constructors for older transactions must provide `time:` explicitly.
Parsed transactions retain the serialized timestamp through transformations and
legacy signing. Version-3 serialization is not intentionally changed.

This release does not claim support for every historic transaction/script or
proof-of-stake staking path. Verify against exact Core test fixtures first.

## Standard derivation

The BIP32 standard uses HMAC key `Bitcoin seed` even for non-Bitcoin networks.
That label remains the default so existing seed phrases derive identical keys.
The optional `key` parameter now functions correctly if explicitly supplied,
which produces a distinct derivation as expected.

## Local development and publish order

1. Run Dart tests and analyzer in `sumcoinlib/`.
2. Run Flutter analyzer in `sumcoinlib_flutter/` and `example/`.
3. Build and test target OS toolchains; integrate fixtures from Sumcoin Core.
4. Publish `sumcoinlib` 0.0.3 **first** if releases to pub.dev are desired.
5. Publish `sumcoinlib_flutter` 0.0.3 after its hosted dependency resolves.

`pubspec_overrides.yaml` in this repository helps local development only.
Example application lockfiles are regenerated locally rather than checked in.
Neither GitHub commits nor these local paths automatically publish packages.
