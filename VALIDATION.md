# Release 0.0.3 validation checklist

The code modifications were generated from the public repository's 2024-06-26
`master` archive. The user should confirm local `master` still matches remote.

## Checks to run

```sh
cd sumcoinlib && dart pub get && dart analyze && dart test -p chrome
cd ../sumcoinlib_flutter && flutter pub get && flutter analyze
cd example && flutter pub get && flutter analyze
```

## Additional release gates

- Test existing production Sumcoin Wallet seed/address fixtures without exposing
  private keys or seed phrases in GitHub issues.
- Compare old v1/v2/v3 transaction IDs and serialization against Sumcoin Core.
- Test current mainnet/testnet address generation and message signing against
  the daemon; confirm supported script/activation rules before broadcasting.
- Verify native builds on macOS/iOS/Android/Linux/Windows, and Flutter web.
- Do not publish a new pub.dev version until both packages pass their checks.

`dart analyze`, WASM browser tests, and Flutter analysis are configured in CI.
They do NOT prove consensus compatibility or successful native builds.

## Test fixture correction (v0.0.3)
After applying the initial source patch, the Chrome suite exposed inherited
Peercoin-prefix addresses (`0x37`/`0x75`), an old WIF prefix (`0xb7`), and
BIP32 fixtures encoded using generic `xprv`/`xpub` version bytes. The updated
fixtures retain the original key material and hash160 payloads, but encode them
with Sumcoin Core prefixes. The synthetic Taproot reference transaction was
converted from legacy version 2 to version 3 because Sumcoin legacy v2 needs
`nTime`; its expected BIP341 hashes were independently recomputed.
Test failures must block publishing and git tags.
