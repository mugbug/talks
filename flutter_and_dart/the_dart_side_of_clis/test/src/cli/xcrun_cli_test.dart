import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:process_run/shell.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:the_dart_side_of_clis/src/cli/cli.dart';

import '../../helpers/setup_helper.dart';

void main() {
  group('XCRun >', () {
    group('open url', () {
      test('should succeed for custom schemes', () async {
        await withShell((shellListener, processResult, logger) async {
          final sut = XCRun(logger);

          when(() => processResult.exitCode).thenReturn(ExitCode.success.code);

          await expectLater(
            sut.openUrl('shoebox://'),
            completes,
          );

          expect(
            shellListener,
            emitsInOrder([
              'xcrun simctl openurl booted "shoebox://"',
            ]),
          );
        });
      });

      test('should throw if something fails', () async {
        await withShell((shellListener, processResult, logger) async {
          final sut = XCRun(logger);

          when(() => processResult.exitCode).thenReturn(ExitCode.tempFail.code);
          when(() => processResult.errLines.first).thenReturn(
            'Something went wrong...',
          );

          await expectLater(
            sut.openUrl('shoebox://'),
            throwsA(isA<ProcessException>()),
          );

          expect(
            shellListener,
            emitsInOrder([
              'xcrun simctl openurl booted "shoebox://"',
            ]),
          );

          verify(
            () => logger.err('''
[INFO]
null
[FAILURE]
Something went wrong...'''),
          ).called(1);
        });
      });
    });
  });
}
