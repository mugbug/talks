import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../helpers/setup_helper.dart';

void main() {
  group('open_url', () {
    test('should open url correctly', () async {
      await withRunner((commandRunner, mocks) async {
        const expectedUrl = 'shoebox://';

        when(() => mocks.xcrun.openUrl(any())).thenAnswer(
          (_) => Future.value(),
        );

        final exitCode = await commandRunner.run(
          ['open_url', '-u', expectedUrl],
        );

        expect(exitCode, ExitCode.success.code);

        verify(() => mocks.logger.progress('Launching $expectedUrl')).called(1);
        verify(() => mocks.xcrun.openUrl(expectedUrl)).called(1);
        verify(
          () => mocks.progress.complete(
            'Launched $expectedUrl on iOS simulator',
          ),
        ).called(1);
      });
    });

    test('may fail opening url', () async {
      await withRunner((commandRunner, mocks) async {
        const expectedUrl = 'shoebox://';

        when(() => mocks.xcrun.openUrl(any())).thenAnswer(
          (_) => Future.error(Exception('Something went wrong...')),
        );

        final exitCode = await commandRunner.run(
          ['open_url', '-u', expectedUrl],
        );

        expect(exitCode, ExitCode.tempFail.code);

        verify(() => mocks.logger.progress('Launching $expectedUrl')).called(1);
        verify(() => mocks.xcrun.openUrl(expectedUrl)).called(1);
        verify(
          () => mocks.progress.fail(
            'Error launching $expectedUrl',
          ),
        ).called(1);
      });
    });
  });
}
