<p align="center"><a href="https://sumcoin.org"><img src="https://sumcoin.org/wp-content/uploads/2019/07/sumcoin_400x400.png" width="140" height="140" alt="Official Sumcoin logo"></a></p>

<p align="center">
<a href="https://github.com/sumcoinlabs/sumcoinlib/tree/v0.0.3"><img src="https://img.shields.io/badge/source-v0.0.3-007b8a" alt="Source v0.0.3"></a>
<a href="LICENSE"><img src="https://img.shields.io/badge/license-BSD--3--Clause-blue" alt="BSD-3-Clause License"></a>
<a href="sumcoinlib/"><img src="https://img.shields.io/badge/Dart-library-0175C2?logo=dart&amp;logoColor=white" alt="Dart Library"></a>
<a href="sumcoinlib_flutter/"><img src="https://img.shields.io/badge/Flutter-plugin-02569B?logo=flutter&amp;logoColor=white" alt="Flutter Plugin"></a>
<a href="https://github.com/sumcoinlabs/sumcoinlib/actions/workflows/dart-test-analyze.yml"><img src="https://github.com/sumcoinlabs/sumcoinlib/actions/workflows/dart-test-analyze.yml/badge.svg?branch=master" alt="Live CI workflow status"></a>
</p>

# Sumcoinlib

**Sumcoinlib 0.0.3** is the independent Dart and Flutter library for Sumcoin
addresses, hierarchical deterministic keys, message signatures and UTXO
transaction construction and signing.

This repository is maintained by [Sumcoin Labs](https://github.com/sumcoinlabs).
It is **not a GitHub fork**, and its network configurations are derived from
[Sumcoin Core](https://github.com/sumcoinlabs/sumcoin), not from the original
library's testnet defaults.

## Packages

| Directory | Package | Purpose |
|---|---|---|
| [`sumcoinlib/`](sumcoinlib/) | `sumcoinlib` | Pure Dart API with native/WASM secp256k1 support |
| [`sumcoinlib_flutter/`](sumcoinlib_flutter/) | `sumcoinlib_flutter` | Flutter platform plugin and web initialization widget |

Documentation: [Dart library](sumcoinlib/README.md) · [Flutter plugin](sumcoinlib_flutter/README.md) · [Release notes](CHANGELOG.md) · [Migration guide](MIGRATION.md).

## Compatibility with v0.0.2

**Still the same:** Mainnet wallet/address prefixes, the default BIP32
`Bitcoin seed` derivation, public package import paths, and default v3
transaction serialization. All 289 Dart/Chrome tests passed on October 31, 2026,
and Flutter plugin/example analysis found no issues on the user's Mac.

**Changes requiring attention:** `Network.testnet` now uses Sumcoin Core's real
prefixes; manually constructed v1/v2 transactions require `time:`; a custom
`HDPrivateKey.fromSeed(key: ...)` argument is now honored rather than ignored.
See the [easy-to-read changelog](CHANGELOG.md), [migration guide](MIGRATION.md)
and [verification report](VALIDATION.md). Native builds and live Core
integration have **not** yet been fully verified.

## Development

```sh
cd sumcoinlib && dart pub get && dart analyze && dart test -p chrome
cd ../sumcoinlib_flutter && flutter pub get && flutter analyze
cd example && flutter pub get && flutter analyze
```

The Flutter package includes local development dependency overrides so both
packages can be tested before being published to pub.dev. Production consumers
should use the published packages or a pinned Git ref.

## Important compatibility notes

* The default BIP32 HMAC label remains the industry-standard `Bitcoin seed`.
  Changing it would derive different wallet keys and can break wallet recovery.
* The native `secp256k1` dependency is retained for cryptographic compatibility.
* Versions 1 and 2 of Sumcoin transactions serialize an `nTime` field.
  Version 3 does not. See [migration guide](MIGRATION.md).
* **Do not assume witness or Taproot support means those features are active on
  Sumcoin mainnet**. Verify Core consensus and activation rules before use.
* `v0.0.3` is a tagged source release; it does not prove pub.dev publication
  or validation of all native platforms.

## License and provenance

BSD-3-Clause. See [LICENSE](LICENSE). The library was derived from existing
BSD-3-Clause licensed work; the original copyright attribution is retained as
required by that license. No upstream donation links or network endpoints are
used by this repository.
