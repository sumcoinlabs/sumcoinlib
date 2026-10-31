/// Network-specific address and key encoding parameters.
///
/// Sources of truth: Sumcoin Core `src/chainparams.cpp` and
/// `src/util/message.cpp`. These values are consensus-adjacent: changing them
/// can make existing funds or signed messages unreadable. Do not modify them
/// merely to update branding.
class Network {
  final int wifPrefix, p2pkhPrefix, p2shPrefix, privHDPrefix, pubHDPrefix;
  final String bech32Hrp, messagePrefix;
  final BigInt minFee, minOutput, feePerKb;

  Network({
    required this.wifPrefix,
    required this.p2pkhPrefix,
    required this.p2shPrefix,
    required this.privHDPrefix,
    required this.pubHDPrefix,
    required this.bech32Hrp,
    required this.messagePrefix,
    required this.minFee,
    required this.minOutput,
    required this.feePerKb,
  });

  /// Sumcoin mainnet. Existing wallet prefixes MUST NOT be changed.
  static final mainnet = Network(
    wifPrefix: 187,
    p2pkhPrefix: 63,
    p2shPrefix: 125,
    privHDPrefix: 0xF588ADE5,
    pubHDPrefix: 0xF588B21F,
    bech32Hrp: "sum",
    messagePrefix: "Sumcoin Signed Message:\n",
    minFee: BigInt.from(1000),
    minOutput: BigInt.from(10000),
    feePerKb: BigInt.from(10000),
  );

  /// Sumcoin testnet (NOT Bitcoin or upstream project testnet values).
  static final testnet = Network(
    wifPrefix: 188,
    p2pkhPrefix: 64,
    p2shPrefix: 126,
    privHDPrefix: 0xF488ADE5,
    pubHDPrefix: 0xF488B21F,
    bech32Hrp: "tsum",
    messagePrefix: "Sumcoin Signed Message:\n",
    minFee: BigInt.from(1000),
    minOutput: BigInt.from(10000),
    feePerKb: BigInt.from(10000),
  );

  /// Sumcoin regression-test network; address/key prefixes follow Core.
  static final regtest = Network(
    wifPrefix: 188,
    p2pkhPrefix: 64,
    p2shPrefix: 126,
    privHDPrefix: 0xF488ADE5,
    pubHDPrefix: 0xF488B21F,
    bech32Hrp: "sumr",
    messagePrefix: "Sumcoin Signed Message:\n",
    minFee: BigInt.from(1000),
    minOutput: BigInt.from(10000),
    feePerKb: BigInt.from(10000),
  );
}
