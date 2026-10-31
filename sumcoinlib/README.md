<p align="center"><a href="https://sumcoin.org"><img src="https://sumcoin.org/wp-content/uploads/2019/07/sumcoin_400x400.png" width="96" height="96" alt="Official Sumcoin logo"></a></p>

# Sumcoinlib (Dart) — 0.0.3

Dart tools for **Sumcoin** UTXO keys, base58 and Bech32/Bech32m addresses,
message signatures, and versioned transaction encoding/signing.

## Install

```sh
dart pub add sumcoinlib
```

For local development from this repository use `dart pub get` in this directory.
On browser targets the bundled secp256k1 WASM is used. Native Dart applications
require a compatible secp256k1 shared library; see build scripts under `bin/`.

```dart
import 'package:sumcoinlib/sumcoinlib.dart';

Future<void> main() async {
  await loadSumCoinlib();
  final network = Network.mainnet;
  print('Sumcoin mainnet prefix: ${network.bech32Hrp}');
}
```

## Network parameters

| Network | P2PKH | P2SH | WIF | xpub | xprv | HRP |
|---|---:|---:|---:|---|---|---|
| Mainnet | 63 | 125 | 187 | `F588B21F` | `F588ADE5` | `sum` |
| Testnet | 64 | 126 | 188 | `F488B21F` | `F488ADE5` | `tsum` |
| Regtest | 64 | 126 | 188 | `F488B21F` | `F488ADE5` | `sumr` |

Source: [`src/chainparams.cpp`](https://github.com/sumcoinlabs/sumcoin/blob/master/src/chainparams.cpp) in Sumcoin Core. Standard BIP32 seed derivation retains
`Bitcoin seed` for compatibility; don't rename it.

## Transaction timestamp compatibility

Sumcoin Core serializes `nTime` for transaction versions below 3. This library
now reads, writes and preserves that field. When constructing a legacy version
1 or 2 transaction yourself, **pass an explicit `time`**:

```dart
final legacyTx = Transaction(
  version: 2,
  time: 1500000000,
  inputs: [],
  outputs: [],
);
```

Version 3 transactions omit the field and should not supply `time`. Legacy
transaction data should not be broadcast without consensus-level validation.
See [`MIGRATION.md`](../MIGRATION.md).

## Developer commands

```sh
dart pub get
dart analyze
dart test -p chrome
```

The test runner uses the bundled secp256k1 WebAssembly on Chrome. Native
platform builds require the platform-specific secp256k1 toolchain; see
`bin/build_linux.dart`, `bin/build_macos.dart`, and `bin/build_windows.dart`.

The license retains original BSD-3-Clause copyright notices.
