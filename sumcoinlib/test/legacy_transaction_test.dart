import 'package:sumcoinlib/sumcoinlib.dart';
import 'package:test/test.dart';

/// Synthetic, independently serialized fixture following Sumcoin Core's
/// v2 layout: version | nTime | vin | vout | locktime.
/// This is NOT a claim that this transaction is accepted on mainnet.
void main() {
  const fixture = '02000000002f6859010000000000000000000000000000000000000000000000000000000000000000ffffffff00ffffffff01a0860100000000000000000000';
  const expectedTxid = 'eb72f20b1234e69a5a847ff05f3e5408e90f9f8ebf5918a26ecbc6fed4960a0f';

  test('legacy v2 nTime is parsed, serialized and included in txid', () {
    final tx = Transaction.fromHex(fixture);
    expect(tx.version, 2);
    expect(tx.time, 1500000000);
    expect(tx.toHex(), fixture);
    expect(tx.txid, expectedTxid);
    expect(tx.legacy.toHex(), fixture);
  });

  test('legacy transaction timestamp survives immutable transforms', () {
    final tx = Transaction.fromHex(fixture);
    final added = tx.addOutput(Output.fromScriptBytes(BigInt.one, hexToBytes('51')));
    expect(added.time, 1500000000);
    expect(added.version, 2);
    expect(Transaction.fromHex(added.toHex()).time, 1500000000);
  });

  test('legacy construction requires timestamp and v3 forbids it', () {
    expect(
      () => Transaction(version: 2, inputs: [], outputs: []),
      throwsArgumentError,
    );
    expect(
      () => Transaction(version: 3, time: 1500000000, inputs: [], outputs: []),
      throwsArgumentError,
    );
    final tx3 = Transaction(version: 3, inputs: [], outputs: []);
    expect(tx3.toHex(), '03000000000000000000');
    expect(tx3.time, isNull);
  });
}
