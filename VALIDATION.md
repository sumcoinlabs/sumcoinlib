# Sumcoinlib v0.0.3 — compatibility verification

This record separates **what we checked** from what still requires live testing.
It does not claim that every existing application can upgrade without changes.

## Verified against v0.0.2

Compared the pre-release repository at
`622c4b1b540ac6a5a566a55109f227bb9ab8e283` with v0.0.3 commit `8dd7a65`.
There are **67 production Dart files** across both `lib/` directories and
only **six** changed:

| File | What changed | Compatibility |
|---|---|---|
| `sumcoinlib/lib/src/network.dart` | Testnet correction and regtest | **Mainnet unchanged**, testnet values changed |
| `sumcoinlib/lib/src/tx/transaction.dart` | Version 1/2 timestamp preservation | Requires `time:` for manual v1/v2 creation; default v3 unchanged |
| `sumcoinlib/lib/src/tx/sighash/legacy_signature_hasher.dart` | Preserve timestamp in legacy signing | Fixes older-version signing data |
| `sumcoinlib/lib/src/crypto/hd_key.dart` | Use optional `key` argument | Default BIP32 unchanged; non-default callers differ |
| `sumcoinlib/lib/sumcoinlib.dart` | Library name/comment | Import path unchanged |
| `sumcoinlib_flutter/lib/sumcoinlib_flutter.dart` | Comment only | No runtime change |

Other modifications affect tests, metadata, native build configuration, demo
assets, and documentation. Native build configuration changes must still be
checked by compiling their platforms; they are not covered by the Dart tests.

## Test results from October 31, 2026

| Check | Observed result | Limitation |
|---|---|---|
| Dart/Chrome/WASM test suite | **289 passed, 0 failed** on the user's Mac | Not native integration |
| Dart static analyzer | Completed; three existing informational brace-style notices | Not zero warnings |
| Flutter plugin analyzer | **No issues found** | Not a compiled platform build |
| Flutter example analyzer | **No issues found** | Not a device run |
| Mainnet constant diff | **Unchanged** | Not a live-node verification |
| Default BIP32 source diff | Default HMAC label remains `Bitcoin seed` | Not real wallet-recovery fixtures |
| Default v3 transaction source diff | Timestamp-free serialization path unchanged | Still needs Core transaction comparisons |

## Cases requiring special care

- `Network.testnet` now uses Sumcoin Core prefixes (rather than inherited
  incorrect values). Recheck testnet addresses and imported keys.
- Manually constructed transaction versions 1 and 2 now require `time:`.
- Applications explicitly using a non-default BIP32 `key:` now get the
  intended custom derivation; the default remains unchanged.

See [MIGRATION.md](MIGRATION.md) and [CHANGELOG.md](CHANGELOG.md).

## Repeat the same checks on a Mac

From the repository root:

```sh
(cd sumcoinlib && dart pub get && dart analyze && dart test -p chrome) && \
(cd sumcoinlib_flutter && flutter pub get && flutter analyze) && \
(cd sumcoinlib_flutter/example && flutter pub get && flutter analyze)
```

## Still required before declaring full backward compatibility

- Compare existing production Sumcoin Wallet seed/address vectors locally.
  Never publish actual seed phrases, private keys or WIF strings.
- Cross-check serialized v1/v2/v3 transactions, hashes, and signatures with
  a matching running Sumcoin Core node.
- Compile and run the native plugin on iOS, macOS, Android, Linux, and Windows;
  verify browser initialization on web.
- Verify script/consensus activation before using witness or Taproot features.

## Documentation follow-up

The follow-up patch only changes the three READMEs, root CHANGELOG.md,
this VALIDATION.md, and deletes unused `logo.svg`. It does **not** modify
any Dart/Flutter runtime source or Sumcoin network parameters. The `v0.0.3`
Git tag stays on its original commit; documentation improvements land on
`master` afterward.
