import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../helpers/setup_helper.dart';

void main() {
  group('semantic_linter', () {
    Future<void> testCorrectMessage(String message) {
      return withRunner(
        (
          commandRunner,
          mocks,
        ) async {
          final exitCode = await commandRunner.run(
            [
              'semantic_linter',
              '--message',
              message,
            ],
          );

          verify(
            () => mocks.logger.progress(
              '🔍 Linting message...',
            ),
          ).called(1);

          verify(
            () => mocks.progress.complete(
              'The message follows the formatting conventions!',
            ),
          ).called(1);

          expect(exitCode, ExitCode.success.code);
        },
      );
    }

    Future<void> testIncorrectPrTitle(String message) {
      return withRunner(
        (
          commandRunner,
          mocks,
        ) async {
          const prNumber = '123';
          const author = 'gh-actions-bot';

          when(
            () => mocks.github.pullRequestAuthor(prNumber: prNumber),
          ).thenAnswer(
            (_) => Future.value(author),
          );

          when(
            () => mocks.github.commentOnPR(
              message: any(named: 'message'),
              prNumber: any(named: 'prNumber'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          final exitCode = await commandRunner.run(
            [
              'semantic_linter',
              '--message',
              message,
              '--pr-number',
              prNumber,
            ],
          );

          verify(
            () => mocks.logger.progress(
              '🔍 Linting message...',
            ),
          ).called(1);

          verify(
            () => mocks.progress.fail(
              'Message do not follow the formatting conventions.',
            ),
          ).called(1);

          verify(
            () => mocks.github.pullRequestAuthor(
              prNumber: prNumber,
            ),
          ).called(1);

          verify(
            () => mocks.github.commentOnPR(
              message: '''
Hello, @$author!

The PR title message does not match the conventions. Try renaming it to follow this pattern:

    type(JIRA-123)!: description
''',
              prNumber: prNumber,
            ),
          ).called(1);

          expect(exitCode, ExitCode.tempFail.code);
        },
      );
    }

    test(
      'when there is a correctly pr title for "fix"',
      () => testCorrectMessage('fix(JIRA-123): Description'),
    );

    test(
      'when there is a correctly pr title for "feat"',
      () => testCorrectMessage('feat(JIRA-123): Description'),
    );

    test(
      'when there is a correctly pr title for "docs"',
      () => testCorrectMessage('docs(JIRA-123): Description'),
    );

    test(
      'when there is a correctly pr title with breaking changes',
      () => testCorrectMessage('feat(JIRA-123)!: Description'),
    );

    test(
      'when there is no type',
      () => testIncorrectPrTitle('(JIRA-123): Description'),
    );

    test(
      'when there is no ticket',
      () => testIncorrectPrTitle('feat: Description'),
    );

    test(
      'when there is no description',
      () => testIncorrectPrTitle('feat(JIRA-123)'),
    );

    test(
      'when there is an invalid type',
      () => testIncorrectPrTitle('type(JIRA-123): Description'),
    );

    test('wrong usage', () async {
      await withRunner(
        (
          commandRunner,
          mocks,
        ) async {
          const helpMessage = '''
Usage: the_dart_side_of_clis semantic_linter [arguments]
-h, --help                   Print this usage information.
-m, --message (mandatory)    The message to be validated.
    --pr-number              If set, will comment on the PR in case of failure.

Run "the_dart_side_of_clis help" to see global options.''';

          final exitCode = await commandRunner.run(
            ['semantic_linter'],
          );

          expect(exitCode, ExitCode.usage.code);

          verify(
            () => mocks.logger.err('Option message is mandatory.'),
          ).called(1);

          verify(
            () => mocks.logger.info(helpMessage),
          ).called(1);
        },
      );
    });
  });
}
