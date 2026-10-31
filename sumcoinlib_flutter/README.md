# Sumcoinlib Flutter — 0.0.3

Cross-platform Flutter wrapper for `sumcoinlib` with native `secp256k1`
compilation and a web-capable initialization widget.

## Install

After both versions are available on pub.dev:

```sh
flutter pub add sumcoinlib_flutter
```

For local development inside this repository, `pubspec_overrides.yaml`
resolves the Dart package from `../sumcoinlib`. The example app references
this local Flutter plugin, so no unpublished hosted package is required.

```dart
import 'package:flutter/widgets.dart';
import 'package:sumcoinlib_flutter/sumcoinlib_flutter.dart';

class SumcoinScreen extends StatelessWidget {
  const SumcoinScreen({super.key});

  @override
  Widget build(BuildContext context) => SumCoinlibLoader(
    loadChild: const Center(child: Text('Loading Sumcoin')),
    errorBuilder: (context, error) => Center(child: Text('$error')),
    builder: (context) => const Center(child: Text('Sumcoin is ready')),
  );
}
```

`SumCoinlibLoader` ensures the secp256k1 backend is ready, particularly for web.
Android, iOS, macOS, Linux, Windows, and web builds use their respective Flutter
and native toolchains. Some platforms require locally built `secp256k1`; see
[`sumcoinlib/README.md`](../sumcoinlib/README.md) and `src/CMakeLists.txt`.

Run `flutter pub get` and `flutter analyze` here, then repeat in `example/`.
Do not treat a successful Dart analysis as validation of every native target.
