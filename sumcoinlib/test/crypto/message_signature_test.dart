import 'package:sumcoinlib/sumcoinlib.dart';
import 'package:test/test.dart';
import '../vectors/keys.dart';

// This is a deterministic test-only private key serialized with Sumcoin WIF
// prefix 187. The key itself is unchanged from the upstream signature fixture.
final privKey = WIF.fromString(
  "UmbGCmCWewRuuNLQXFzZ1gXgDraA5zYToEaiFdPjzhFMiiPXe5ih",
  version: Network.mainnet.wifPrefix,
).privkey;
final addrs = [
  P2PKHAddress.fromPublicKey(
    privKey.pubkey, version: Network.mainnet.p2pkhPrefix,
  ),
  P2WPKHAddress.fromPublicKey(
    privKey.pubkey, hrp: Network.mainnet.bech32Hrp,
  ),
];
// Known-answer vectors signed with deterministic RFC6979 ECDSA using the
// Sumcoin Signed Message prefix from Sumcoin Core. Not sample wallet funds.
final msgSigs = [
  [
    "Hello, this is a message",
    "H6tkGPZgWmDleOYwTz45qCgVRj4EcmAokDbr/ELkiJjBBXLowBlPKovdUvi4TNojJohP5OLWOosU2lmqzrU9baE=",
  ],
  [
    "The recid for this message is 1",
    "IAeDJMJic4btzCWDS0PA8fOMBV6S8psfiPX07cP0MQd8WuG4+3L/rtB81GNkIkd5dZkLsVhQargA6MxUc2FKMbQ=",
  ],
];

final prefix = Network.mainnet.messagePrefix;

void main() {
  group("MessageSignature", () {

    setUpAll(loadSumCoinlib);

    test("can sign messages", () {
      for (final vec in msgSigs) {
        final msgSig = MessageSignature.sign(
          key: privKey,
          message: vec[0],
          prefix: prefix,
        );
        expect(msgSig.toString(), vec[1]);
      }
    });

    test("verifies against public key and address", () {
      for (final vec in msgSigs) {
        final msgSig = MessageSignature.fromBase64(vec[1]);
        expect(
          msgSig.verifyPublicKey(
            pubkey: privKey.pubkey,
            message: vec[0],
            prefix: prefix,
          ),
          true,
        );
        for (final addr in addrs) {
          expect(
            msgSig.verifyAddress(
              address: addr,
              message: vec[0],
              prefix: prefix,
            ),
            true,
          );
        }
      }
    });

    test("fails against wrong public key or address", () {
      final msgSig = MessageSignature.fromBase64(msgSigs[0][1]);
      expect(
        msgSig.verifyPublicKey(
          pubkey: keyPairVectors[0].publicObj,
          message: msgSigs[0][0],
          prefix: prefix,
        ),
        false,
      );
      expect(
        msgSig.verifyAddress(
          address: Address.fromString(
            "SMJ12qn9jNCCXJnTYRz5Yu9ZenERqvYwfg",
            Network.mainnet,
          ),
          message: msgSigs[0][0],
          prefix: prefix,
        ),
        false,
      );
    });

  });

}
