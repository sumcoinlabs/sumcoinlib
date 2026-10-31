import 'package:sumcoinlib/sumcoinlib.dart';
import 'package:test/test.dart';

// Standard BIP32 derivation vectors re-encoded with Sumcoin Core's 4-byte
// extended-key prefixes. Private keys, chain codes, paths and fingerprints
// are unchanged; the Base58Check envelope is the only difference.
final privPrefix = Network.mainnet.privHDPrefix;
final pubPrefix = Network.mainnet.pubHDPrefix;

class HDVector {
  final String? seedHex;
  final String privHex;
  final String chaincodeHex;
  final String privEncoded;
  final String pubEncoded;
  final String identifierHex;
  final int fingerprint;
  final int depth;
  final int index;
  final bool hardened;

  HDVector({
    required this.seedHex,
    required this.privHex,
    required this.chaincodeHex,
    required this.privEncoded,
    required this.pubEncoded,
    required this.identifierHex,
    required this.fingerprint,
    required this.depth,
    required this.index,
    required this.hardened,
  });

  void expectHDKey(HDKey key) {

    late HDPublicKey pubKey;
    if (key is HDPrivateKey) {
      expect(bytesToHex(key.privateKey.data), privHex);
      expect(key.encode(privPrefix), privEncoded);
      pubKey = key.hdPublicKey;
    } else {
      expect(key.privateKey, null);
      pubKey = key as HDPublicKey;
    }

    expect(pubKey.encode(pubPrefix), pubEncoded);
    expect(bytesToHex(key.chaincode), chaincodeHex);
    expect(bytesToHex(key.identifier), identifierHex);
    expect(key.fingerprint, fingerprint);
    expect(key.depth, depth);
    expect(key.index, index);

  }

  // Adds a static check to the key type
  void expectHDPrivateKey(HDPrivateKey key) => expectHDKey(key);

}

final hdVectors = [
  [
    HDVector(
      seedHex: "000102030405060708090a0b0c0d0e0f",
      privHex: "e8f32e723decf4051aefac8e2c93c9c5b214313817cdb01a1494b917c8436b35",
      chaincodeHex: "873dff81c02f525623fd1fe5167eac3a55a049de3d314bb42ee227ffed37d508",
      privEncoded: "u8Dc44wHdV4vjanxQ7bauojfN943mgivveSCezNs7CXNWHb6zd4A4VKgojFrzFjdqijqTdmCp12N5S6me3cWnVYs4hPsfawNGqbAyrK4n5ArwPod",
      pubEncoded: "u8Dej1AGytaTdRAWhL5fNumCNWBzWEkmR3tvWMbnhzun7qvdyVrVD2s14H4BU71H9EdFXZJ6kVyPE5Q7wr8hvnnhiKRskNe6W17gacRfX7b2tTGn",
      identifierHex: "3442193e1bb70916e914552172cd4e2dbc9df811",
      fingerprint: 0x3442193e,
      depth: 0,
      index: 0,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "edb2e14f9ee77d26dd93b4ecede8d16ed408ce149b6cd80b0715a2d911a0afea",
      chaincodeHex: "47fdacbd0f1097043b78c63c20c34ef4ed9a111d980047ad16282c7ae6236141",
      privEncoded: "u8Dc44yZ3UnECg45PGCid1VY1269t1YVH2WgffzJ1AckdFnJGzLTEuZDtrQDQ2zzB8TDRLp6WNKgwpTcWmNYW999FVTxBep3R5YssZKhdWP23Sf5",
      pubEncoded: "u8Dej1CYPtHm6WRdgUgo67X51PE6cZaKmRyQX3DDby1AEp7qFs8nPT6Y9QCXstGqqywA4ZWPKNCvep3C2pXg4jpS6PKLUaGtkvRao8Mo5RFWc9gs",
      identifierHex: "5c1bd648ed23aa5fd50ba52b2457c11e9e80a6a7",
      fingerprint: 0x5c1bd648,
      depth: 1,
      index: 2147483648,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "3c6cb8d0f6a264c91ea8b5030fadaa8e538b020f0a387421a12de9319dc93368",
      chaincodeHex: "2a7857631386ba23dacac34180dd1983734e444fdbf774041578e9b6adb37c19",
      privEncoded: "u8Dc451jAgZn64kxT6em4jkRscq3Y4vUP2YQxcJxqktXSCR6VDsxNdMeCoy7dT4BEjNzTntrCB9HNuAZvuK4jGUwEGdSdAb199JejE8213MPntDv",
      pubEncoded: "u8Dej1EiX65Jyu8WkK8qXqmxsyxzGcxJsS18oyXtSZGw3kkdU6gHXAtxTMmS7JMJRPssQXE1N9dNkvdgWQqQtD9bz4yAQsUjcQ4b4m6Kri7kTj5V",
      identifierHex: "bef5a2f9a56a94aab12459f72ad9cf8cf19c7bbe",
      fingerprint: 0xbef5a2f9,
      depth: 2,
      index: 1,
      hardened: false,
    ),
    HDVector(
      seedHex: null,
      privHex: "cbce0d719ecf7431d88e6a89fa1483e02e35092af60c042b1df2ff59fa424dca",
      chaincodeHex: "04466b9cc8e161e966409ca52986c584f07e9dc81f735db683c3ff6ec7b1503f",
      privEncoded: "u8Dc454LSj6bwmdorxpZ9zLqEyq5gJ5LuJ5zwwrCX1DpbNHTvdj9VS7UdiQfZ16PrhcVxJMsamcEJKaPq8WoUrVrRPitHXCZhJEtfqPmDftVwuQm",
      pubEncoded: "u8Dej1HKo8c8qc1NABJdd6NNFLy2Qr7BPhYioK587ocECvczuWXUdyentGCz2rNVFqkJisk76m1MNJaFUsAZAvF9X8RKFTNhkV1ekUnEzoN5kSmT",
      identifierHex: "ee7ab90cde56a8c0e2bb086ac49748b8db9dce72",
      fingerprint: 0xee7ab90c,
      depth: 3,
      index: 2147483650,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "0f479245fb19a38a1954c5c7c0ebab2f9bdfd96a17563ef28a6a4b1a2a764ef4",
      chaincodeHex: "cfb71883f01676f587d023cc53a35bc7f88f724b1f8c2892ac1275ac822a3edd",
      privEncoded: "u8Dc456ZqZXitx7Ur3J2sgc3KsLEzNtddvgK9PL5pGBM4gj2XzpmrVtAzuz8UgQoKAGuPNA1HPXTsEPqzbhhw3vPmb7UKvSenrKiNzNEPBPYZZXJ",
      pubEncoded: "u8Dej1KZBy3FnnV39Fn7LndaLEUBivvU8L92zkZ1R4ZkgF4ZWsd713RVFTnSxXhUeFYTTM4EGu1qKMK9bRauB1Yair1nWNAFwKCYaVU9qx2tHgTJ",
      identifierHex: "d880d7d893848509a62d8fb74e32148dac68412f",
      fingerprint: 0xd880d7d8,
      depth: 4,
      index: 2,
      hardened: false,
    ),
    HDVector(
      seedHex: null,
      privHex: "471b76e389e528d6de6d816857e012c5455051cad6660850e58372a6c3e6e7c8",
      chaincodeHex: "c783e67b921d2beb8f6b389cc646d7263b4145701dadd2161548a8b078e65e9e",
      privEncoded: "u8Dc458Hc3DL95Es3ZdpKo9c4B3EzB8CwkB8BBaUNWTjCtoR2hxBF2JRfB6HYKGaX5C2TyZQYAtSp5SP7bsiJazQVi57sFwR1yEU6GhnjvWd2Ghq",
      pubEncoded: "u8Dej1MGxSis2ucRLn7tnuB94YBBijA3S9dr2YoPyJr8pT8x1akWPZqjuitc2AXPb6oYApkWpQMm7tWrC21JC7Q5ZhGwdEhg27g8DJRmmC8drj21",
      identifierHex: "d69aa102255fed74378278c7812701ea641fdf32",
      fingerprint: 0xd69aa102,
      depth: 5,
      index: 1000000000,
      hardened: false,
    ),
  ],
  [
    HDVector(
      seedHex: "fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542",
      privHex: "4b03d6fc340455b363f51020ad3ecca4f0850280cf436c70c727923f6db46c3e",
      chaincodeHex: "60499f801b896d83179a4374aeb7822aaeaceaa0db1f85ee3e904c4defbd9689",
      privEncoded: "u8Dc44wHdV4vjanxQ7D6EutjebFmXvv5ML4TUfxeqVU7LFyDrv3BFfUTkAA2aboQtuFPYsoxEkJpXiCoq99EtXyFmJmCS3MSWyw5iRZh1S9Sf6bv",
      pubEncoded: "u8Dej1AGytaTdRAWhKhAi1vGexPiGUwuqjXBL3BaSHrWwpJkqnqWQD1mzhxM4T7N7wscVTrLYQe3PUUdCZvS9uycsTLshEaHxqcBEvoLdPWQrLP7",
      identifierHex: "bd16bee53961a47d6ad888e29545434a89bdfe95",
      fingerprint: 0xbd16bee5,
      depth: 0,
      index: 0,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "abe74a98f6c7eabee0428f53798f0ab8aa1bd37873999041703c742f15ac7e1e",
      chaincodeHex: "f0909affaa7ee7abe5dd4e100598d4dc53cd709d5a5c2cac40e7412f232f7c9c",
      privEncoded: "u8Dc44zZNknch4onUdUgY3g7Xf4B4Hspc32wmE8QCfH8nLP5pc1dEEjopJzbqBJghYKEPHUC4eKEG9NDxVesi6FkpEzMq3XraNRFTYybZoUAfFSD",
      pubEncoded: "u8Dej1DYjAJ9auBLmqxm19heY2C7nquf6SVfcbMKoTfYPticoUoxNnH84rnvK2aL1jxcvgApiGs38sZUAj5rqo8KHnwXyWd2djxKd4HTHphkaDQ2",
      identifierHex: "5a61ff8eb7aaca3010db97ebda76121610b78096",
      fingerprint: 0x5a61ff8e,
      depth: 1,
      index: 0,
      hardened: false,
    ),
    HDVector(
      seedHex: null,
      privHex: "877c779ad9687164e9c2f4f0f4ff0340814392330693ce95a58fe18fd52e6e93",
      chaincodeHex: "be17a268474a6bb9c61e1d720cf6215e2a88c5406c4aee7b38547f585c9a37d9",
      privEncoded: "u8Dc451iS1PeDShxaoLtiU87B8Prcgd3WaX7TKHUjag3Yz7rD4JrgrdE8X4PRnfAgGZxsBhWxRLRuCNj4vtcUpdMwpHoPUG5v8vyiLkw6ZrPk3w7",
      pubEncoded: "u8Dej1EhnQuB7H5Wt1pyBa9eBVXoMEeszyyqJgWQLP4TAYTPBw7BqQAYP4rhudxa8VhE2TgkFvhtkAmtmPkjBa2oQX5zc3heh6gadvfitfTRJai3",
      identifierHex: "d8ab493736da02f11ed682f88339e720fb0379d1",
      fingerprint: 0xd8ab4937,
      depth: 2,
      index: 4294967295,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "704addf544a06e5ee4bea37098463c23613da32020d604506da8c0518e1da4b7",
      chaincodeHex: "f366f48f1ea9f2d1d3fe958c95ca84ea18e4c4ddb9366c336c927eb246fb38cb",
      privEncoded: "u8Dc454XQRQd9cMFmtxZrXnFk6Lnr29v1gi2idiybRjhtJ1Cej8irA8kqQxmodTNJJHAZVesfAdWHbvQHFbPdsWtKpmcgc2ciz2x6pZMq3Zn3KmR",
      pubEncoded: "u8Dej1HWkpvA3Sip57SeKdonkTUjaaBkW6AkZzwuCE87VrLjdbw3zhg55xm6HUkmGHZvK3sComLyyouCbUYzCUwEMnRTWdyrYKE1qrSPquuWKeik",
      identifierHex: "78412e3a2296a40de124307b6485bd19833e2e34",
      fingerprint: 0x78412e3a,
      depth: 3,
      index: 1,
      hardened: false,
    ),
    HDVector(
      seedHex: null,
      privHex: "f1c7c871a54a804afe328b4c83a1c33b8e5ff48f5087273f04efa83b247d6a2d",
      chaincodeHex: "637807030d55d01f9a0cb3a7839515d796bd07706386a6eddf06cc29a65a0e29",
      privEncoded: "u8Dc455hSLNZWDkDVBuoTGG5HTrV2vtPNjgfDfRhUxTQJ8mTuBV3nFogqwV8uGA6gvhYr3EAMUTHGzHys4iV1PTnpWcHrRyA38EyjA9NM7LjWm9G",
      pubEncoded: "u8Dej1Jgnjt6Q47mnQPsvNHcHpzRmUvDs99P52ed5kqouh6zt4HNvoM16VHTP7QtmUwSm1JrSZr3grWXT8C9bApLsVn9xutB2sX7FifURSveF16t",
      identifierHex: "31a507b815593dfc51ffc7245ae7e5aee304246e",
      fingerprint: 0x31a507b8,
      depth: 4,
      index: 4294967294,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "bb7d39bdb83ecf58f2fd82b6d918341cbef428661ef01ab97c28a4842125ac23",
      chaincodeHex: "9452b549be8cea3ecb7a84bec10dcfd94afe4d129ebfd3b3cb58eedf394ed271",
      privEncoded: "u8Dc4574UHon1jvXiwAzLzLCySbs1KwvUz1aJKbKNNEknmZKVFgPMRScc845uLZmh5idv5Y25mCv6SPpZ7GNX7nA3Zb2aEpfYBf7SrWhuBumtRfR",
      pubEncoded: "u8Dej1L3phKJuaJ629f4p6MjyojojsykyPUJ9gpEyAdAQKtrU8UiVxyvrfrQPBoy3cWoTXN4fqmZ6kDYScdD5zv2mp31YZ417otPzPxfc7aRmoLN",
      identifierHex: "26132fdbe7bf89cbc64cf8dafa3f9f88b8666220",
      fingerprint: 0x26132fdb,
      depth: 5,
      index: 2,
      hardened: false,
    ),
  ],
  [
    HDVector(
      seedHex:
      "4b381541583be4423346c643850da4b320e46a87ae3d2a4e6da11eba819cd4acba45d239319ac14f863b8d5ab5a0d0c64d2e8a1e7d1457df2e5a3c51c73235be",
      privHex: "00ddb80b067e0d4993197fe10f2657a844a384589847602d56f0c629c81aae32",
      chaincodeHex: "01d28a3e53cffa419ec122c968b3259e16b65076495494d97cae10bbfec3c36f",
      privEncoded: "u8Dc44wHdV4vjanxQ6GYQSHESoF2ZoZQT5vckPJRPtm8tXfJetHQXKchi7RG75o94rGcsxWczKEWdcdYYVnrCmQQC6EhgZe1ABNRgiHMN65PyLZy",
      pubEncoded: "u8Dej1AGytaTdRAWhJkcsYJmTANyJMbEwVPLbkXLzh9YW5zqdm5jfsA1xfDaaw6u6mUC8dw6QEdvPs9T41E54kgfJsgXqMpCBaAd5iWrKuxbGi8R",
      identifierHex: "41d63b50d8dd5e730cdf4c79a56fc929a757c548",
      fingerprint: 0x41d63b50,
      depth: 0,
      index: 0,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "491f7a2eebc7b57028e0d3faa0acda02e75c33b03c48fb288c41e2ea44e1daef",
      chaincodeHex: "e5fea12a97b927fc9dc3d2cb0d1ea1cf50aa5a1fdc1f933e8906bb38df3377bd",
      privEncoded: "u8Dc44yeqE2ksGAKkHodofRZwrVnEVv1qEn2ennfLhzpjTyE29JXyu7UaBt3pPZVRCDwoQfGQLBJWGNB19LVMLcywqzuJzmvCvXhVqJK23TeDCXw",
      pubEncoded: "u8Dej1CeBdYHm6Xt3WHiGmT6xDdiy3wrKeEkWA1awWPEM2Jm126s8SenpjgNJEpjcVpnsqJbF1bg8i6eYdh1QgvbVSvon2v95827tChDEaPqY51f",
      identifierHex: "c61368bb50e066acd95bd04a0b23d3837fb75698",
      fingerprint: 0xc61368bb,
      depth: 1,
      index: 0x80000000,
      hardened: true,
    ),
  ],
  [
    HDVector(
      seedHex: "3ddd5602285899a946114506157c7997e5444528f3003f6134712147db19b678",
      privHex: "12c0d59c7aa3a10973dbd3f478b65f2516627e3fe61e00c345be9a477ad2e215",
      chaincodeHex: "d0c8a1f6edf2500798c3e0b54f1b56e45f6d03e6076abd36e5e2f54101e44ce6",
      privEncoded: "u8Dc44wHdV4vjanxQ8L3yH1bFbzVTRnzd1B2VdS7oGVpUQC9LjBDrXXJUKdpCmxRBs124XyacRRPmYxkK8oUVRVf7B4N54ssCEFKLzRDWrGGvZk5",
      pubEncoded: "u8Dej1AGytaTdRAWhLp8SP38Fy8SBypq7QdkLzf3Q4tE5xXgKbyZ154cisS8gdE9mnunCDUDxPK9aovDnp6rCAtgDxYPk8EVG8Uatd7XYznjBm4c",
      identifierHex: "ad85d95573bc609b98f2af5e06e150351f818ba9",
      fingerprint: 0xad85d955,
      depth: 0,
      index: 0,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "00d948e9261e41362a688b916f297121ba6bfb2274a3575ac0e456551dfd7f7e",
      chaincodeHex: "cdc0f06456a14876c898790e0b3b1a41c531170aec69da44ff7b7265bfe7743b",
      privEncoded: "u8Dc44zSjsT3PxZ4qmD56uLX2cPbDsistiUZ3NjjTcTzT3eDKDiGy5rjCTgVYwWLRupCRVxc3wzZzsQrQ5Tfb2sKkBhEzvGAsSAmLygFKb9am5Wy",
      pubEncoded: "u8Dej1DS6GxaHnvd8yh9a1N42yXXxRkiP7wGtjxf4QrQ4bykJ6Wc7dQ3T1Up2npRXpY9KdZzKLMYCQrA3M2YFsg8d3rSnAYvE1HgGfv5boEc2Jbq",
      identifierHex: "cfa61281b1762be25710658757221a6437cbcdd6",
      fingerprint: 0xcfa61281,
      depth: 1,
      index: 0x80000000,
      hardened: true,
    ),
    HDVector(
      seedHex: null,
      privHex: "3a2086edd7d9df86c3487a5905a1712a9aa664bce8cc268141e07549eaa8661d",
      chaincodeHex: "a48ee6674c5264a237703fd383bccd9fad4d9378ac98ab05e6e7029b06360c0d",
      privEncoded: "u8Dc452aRXSSQUH7SSMvk3cRviGB53f3yDQFr2fnHPDWehqJkzobUxMCugoTRqUJWyDEFaj1A8bPxe3xGnRVJRoGsU5iEAbstYD1fqMo1gjth1ob",
      pubEncoded: "u8Dej1FZmvwyJJefjer1D9dxw5Q7obgtTcryhPthtBbvGGAqjsbvdVtXAEbmugmC4fin1DMbgE8UJsJW2KWsALGwmm9P9WLmGy2ADYLSVrhbi1cy",
      identifierHex: "48b2a62638e9cb9b68f87671bc80041dbd3acf70",
      fingerprint: 0x48b2a626,
      depth: 2,
      index: 0x80000001,
      hardened: true,
    ),
  ]
];

final masterVector = hdVectors[0][0];
final masterHDKey = HDPrivateKey.decode(masterVector.privEncoded, privPrefix);

