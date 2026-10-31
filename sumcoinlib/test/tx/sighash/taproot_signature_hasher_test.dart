import 'package:sumcoinlib/sumcoinlib.dart';
import 'package:test/test.dart';

// Synthetic nine-input BIP341 fixture adapted to Sumcoin Core v3 serialization.
// The independent TapSighash reference calculation was checked against all
// eight original BIP341 expected hashes before regenerating these v3 hashes.
// Version 1/2 transactions require nTime; v3 deliberately omits it.
const String txHex =
"03000000097de20cbff686da83a54981d2b9bab3586f4ca7e48f57f5b55963115f3b334e9c010000000000000000d7b7cab57b1393ace2d064f4d4a2cb8af6def61273e127517d44759b6dafdd990000000000fffffffff8e1f583384333689228c5d28eac13366be082dc57441760d957275419a418420000000000fffffffff0689180aa63b30cb162a73c6d2a38b7eeda2a83ece74310fda0843ad604853b0100000000feffffffaa5202bdf6d8ccd2ee0f0202afbbb7461d9264a25e5bfd3c5a52ee1239e0ba6c0000000000feffffff956149bdc66faa968eb2be2d2faa29718acbfe3941215893a2a3446d32acd050000000000000000000e664b9773b88c09c32cb70a2a3e4da0ced63b7ba3b22f848531bbb1d5d5f4c94010000000000000000e9aa6b8e6c9de67619e6a3924ae25696bb7b694bb677a632a74ef7eadfd4eabf0000000000ffffffffa778eb6a263dc090464cd125c466b5a99667720b1c110468831d058aa1b82af10100000000ffffffff0200ca9a3b000000001976a91406afd46bcdfd22ef94ac122aa11f241244a37ecc88ac807840cb0000000020ac9a87f5594be208f8532db38cff670c450ed2fea8fcdefcc9a663f78bab962b0065cd1d";

final prevOuts = [
  Output.fromScriptBytes(
    BigInt.parse("420000000"),
    hexToBytes("512053a1f6e454df1aa2776a2814a721372d6258050de330b3c6d10ee8f4e0dda343"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("462000000"),
    hexToBytes("5120147c9c57132f6e7ecddba9800bb0c4449251c92a1e60371ee77557b6620f3ea3"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("294000000"),
    hexToBytes("76a914751e76e8199196d454941c45d1b3a323f1433bd688ac"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("504000000"),
    hexToBytes("5120e4d810fd50586274face62b8a807eb9719cef49c04177cc6b76a9a4251d5450e"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("630000000"),
    hexToBytes("512091b64d5324723a985170e4dc5a0f84c041804f2cd12660fa5dec09fc21783605"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("378000000"),
    hexToBytes("00147dd65592d0ab2fe0d0257d571abf032cd9db93dc"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("672000000"),
    hexToBytes("512075169f4001aa68f15bbed28b218df1d0a62cbbcf1188c6665110c293c907b831"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("546000000"),
    hexToBytes("5120712447206d7a5238acc7ff53fbe94a3b64539ad291c7cdbc490b7577e4b17df5"),
  ),
  Output.fromScriptBytes(
    BigInt.parse("588000000"),
    hexToBytes("512077e30a5522dd9f894c3f8b8bd4c4b2cf82ca7da8a3ea6a239655c39c050ab220"),
  ),
];

class TaprootSignatureVector {
  final int inputN;
  final SigHashType hashType;
  final String? leafHashHex;
  final String sigHashHex;
  TaprootSignatureVector({
    required this.inputN,
    required this.hashType,
    this.leafHashHex,
    required this.sigHashHex,
  });
}

final taprootSigVectors = [
  TaprootSignatureVector(
    inputN: 0,
    hashType: SigHashType.single(),
    sigHashHex: "a5369d31e858ac299cab23ebd4e6bd8bd88f0a8da43a94bfe757df8b0fd27b56",
  ),
  TaprootSignatureVector(
    inputN: 1,
    hashType: SigHashType.single(anyOneCanPay: true),
    sigHashHex: "c9584f2eb71721be27934d00f8dd2af671285d3ad41ea53df3ab243b8af50708",
  ),
  TaprootSignatureVector(
    inputN: 3,
    hashType: SigHashType.all(),
    sigHashHex: "5c918515b55f90264e49a998d026aa3ba84f5104370e90660400bde121eac778",
  ),
  TaprootSignatureVector(
    inputN: 4,
    hashType: SigHashType.schnorrDefault(),
    sigHashHex: "bca80e0b22321a956a4b1d36c0981bdf947c6747f7269c27720962f1bac103f6",
  ),
  TaprootSignatureVector(
    inputN: 6,
    hashType: SigHashType.none(),
    sigHashHex: "ed6a7358ec299007447c9fa594c75bdf905067a95e2a50463e367c15bc814e9f",
  ),
  TaprootSignatureVector(
    inputN: 7,
    hashType: SigHashType.none(anyOneCanPay: true),
    sigHashHex: "91009a6d0a5e816f082a97cc28c4ea1a044d42c10b60fdc665944fc7cf896ba9",
  ),
  TaprootSignatureVector(
    inputN: 8,
    hashType: SigHashType.all(anyOneCanPay: true),
    sigHashHex: "09f0a5fc1e961e466c742a231c8857c40499c0d05600429a1a5267dcd22dc4f5",
  ),
  TaprootSignatureVector(
    inputN: 0,
    hashType: SigHashType.single(),
    sigHashHex: "2eeea76218c52072fad38e43c360b8d4c15ce4b30462f8a2cd642d8a32c80561",
    leafHashHex: "2bfe58ab6d9fd575bdc3a624e4825dd2b375d64ac033fbc46ea79dbab4f69a3e",
  ),
];

void main() {

  late Transaction tx;

  setUpAll(() async {
    await loadSumCoinlib();
    tx = Transaction.fromHex(txHex);
  });

  test("produces correct signature hash", () {
    for (final vec in taprootSigVectors) {
      expect(
        bytesToHex(
          TaprootSignatureHasher(
            tx: tx,
            inputN: vec.inputN,
            prevOuts: prevOuts,
            leafHash: vec.leafHashHex == null
              ? null
              : hexToBytes(vec.leafHashHex!),
            hashType: vec.hashType,
          ).hash,
        ),
        vec.sigHashHex,
      );
    }
  });

  test("input out of range", () => expect(
    () => TaprootSignatureHasher(
      tx: tx,
      inputN: 9,
      prevOuts: prevOuts,
      hashType: SigHashType.all(),
    ),
    throwsArgumentError,
  ),);

  test("prevOuts length incorrect", () => expect(
    () => TaprootSignatureHasher(
      tx: tx,
      inputN: 0,
      prevOuts: prevOuts.sublist(0, prevOuts.length-1),
      hashType: SigHashType.all(),
    ),
    throwsArgumentError,
  ),);

}
