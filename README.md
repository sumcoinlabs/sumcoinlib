<p align="center"><img src="logo.svg" alt="Sumcoinlib" width="460"></p>

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
* Published package version 0.0.3 is a source release; do not call it
  production validated until tests and target-platform builds pass.

## License and provenance

BSD-3-Clause. See [LICENSE](LICENSE). The library was derived from existing
BSD-3-Clause licensed work; the original copyright attribution is retained as
required by that license. No upstream donation links or network endpoints are
used by this repository.
