import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:process_run/shell.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:the_dart_side_of_clis/src/cli/cli.dart';

import '../../helpers/setup_helper.dart';

void main() {
  group('GitHub >', () {
    group('get pull request author', () {
      test('should succeed', () async {
        await withShell((shellListener, processResult, logger) async {
          final sut = GitHub(logger);

          when(() => processResult.exitCode).thenReturn(ExitCode.success.code);
          when(() => processResult.outLines.first).thenReturn('gh-actions-bot');

          await expectLater(
            sut.pullRequestAuthor(prNumber: '123'),
            completion('gh-actions-bot'),
          );

          expect(
            shellListener,
            emitsInOrder([
              'gh pr view 123 --json author --template {{.author.login}}',
            ]),
          );
        });
      });

      test('should fail', () async {
        await withShell((shellListener, processResult, logger) async {
          final sut = GitHub(logger);

          when(() => processResult.exitCode).thenReturn(ExitCode.tempFail.code);
          when(() => processResult.errLines.first).thenReturn(
            'Something went wrong...',
          );

          await expectLater(
            sut.pullRequestAuthor(prNumber: '123'),
            throwsA(isA<ProcessException>()),
          );

          expect(
            shellListener,
            emitsInOrder([
              'gh pr view 123 --json author --template {{.author.login}}',
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

    group('comment on pull request', () {
      test('should succeed', () async {
        await withShell((shellListener, processResult, logger) async {
          final sut = GitHub(logger);

          when(() => processResult.exitCode).thenReturn(ExitCode.success.code);

          await expectLater(
            sut.commentOnPR(
              message: '''
hey this is an awesome
message
''',
              prNumber: '123',
            ),
            completes,
          );

          expect(
            shellListener,
            emitsInOrder([
              'gh pr review 123 --comment --body-file ./tmp_review_body.txt',
            ]),
          );
        });
      });

      test('should fail', () async {
        await withShell((shellListener, processResult, logger) async {
          final sut = GitHub(logger);

          when(() => processResult.exitCode).thenReturn(ExitCode.tempFail.code);
          when(() => processResult.errLines.first).thenReturn(
            'Something went wrong...',
          );

          await expectLater(
            sut.commentOnPR(
              message: '''
hey this is an awesome
message
''',
              prNumber: '123',
            ),
            throwsA(isA<ProcessException>()),
          );

          expect(
            shellListener,
            emitsInOrder([
              'gh pr review 123 --comment --body-file ./tmp_review_body.txt',
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
