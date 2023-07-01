import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// This method will be called before every test file is executed.
/// This is a good place to define shared `setUp` and `tearDown`.
///
/// More info: https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  tearDown(() {
    resetMocktailState();
  });

  await testMain();
}
