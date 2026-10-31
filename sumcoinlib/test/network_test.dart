import 'package:sumcoinlib/sumcoinlib.dart';
import 'package:test/test.dart';

void main() {
  group('Sumcoin Core network parameter parity', () {
    test('mainnet uses deployed wallet/address encodings', () {
      final network = Network.mainnet;
      expect(network.wifPrefix, 187);
      expect(network.p2pkhPrefix, 63);
      expect(network.p2shPrefix, 125);
      expect(network.privHDPrefix, 0xF588ADE5);
      expect(network.pubHDPrefix, 0xF588B21F);
      expect(network.bech32Hrp, 'sum');
      expect(network.messagePrefix, 'Sumcoin Signed Message:\n');
    });

    test('testnet does not reuse the old upstream encodings', () {
      final network = Network.testnet;
      expect(network.wifPrefix, 188);
      expect(network.p2pkhPrefix, 64);
      expect(network.p2shPrefix, 126);
      expect(network.privHDPrefix, 0xF488ADE5);
      expect(network.pubHDPrefix, 0xF488B21F);
      expect(network.bech32Hrp, 'tsum');
    });

    test('regtest has distinct witness HRP', () {
      expect(Network.regtest.p2pkhPrefix, Network.testnet.p2pkhPrefix);
      expect(Network.regtest.wifPrefix, Network.testnet.wifPrefix);
      expect(Network.regtest.bech32Hrp, 'sumr');
    });

    test('new Sumcoin testnet/regtest P2PKH addresses round trip', () {
      for (final network in [Network.testnet, Network.regtest]) {
        final address = P2PKHAddress.fromHash(
          hexToBytes('0000000000000000000000000000000000000000'),
          version: network.p2pkhPrefix,
        );
        final parsed = Address.fromString(address.toString(), network);
        expect(parsed.toString(), address.toString());
      }
    });
  });
}
