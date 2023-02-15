import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:the_dart_side_of_clis/src/cli/cli.dart';

/// {@template semantic_linter_command}
///
/// `the_dart_side_of_clis semantic_linter`
/// Validates the given message to make sure it meets our conventions
/// {@endtemplate}
class SemanticLinterCommand extends Command<int> {
  /// {@macro semantic_linter_command}
  SemanticLinterCommand({
    required this.logger,
    required this.github,
  }) {
    argParser
      ..addOption(
        'message',
        abbr: 'm',
        help: 'The message to be validated.',
        mandatory: true,
      )
      ..addOption(
        'pr-number',
        help: 'If set, will comment on the PR in case of failure.',
      );
  }

  @override
  String get description => 'Validates the given message to '
      'make sure it meets our conventions';

  @override
  String get name => 'semantic_linter';

  final Logger logger;
  final GitHub github;

  @override
  Future<int> run() async {
    final message = argResults?['message'] as String;
    final prNumber = argResults?['pr-number'] as String?;

    final validationProgress = logger.progress(
      '🔍 Linting message...',
    );

    final regex = RegExp(
      r'^(feat|fix|docs)(\((([a-zA-Z]+\-[0-9]+))\))!?:(.*)$',
    );
    final found = regex.hasMatch(message);

    if (!found) {
      validationProgress.fail(
        'Message do not follow the formatting conventions.',
      );

      if (prNumber != null) {
        final author = await github.pullRequestAuthor(
          prNumber: prNumber,
        );
        await github.commentOnPR(
          message: '''
Hello, @$author!

The PR title message does not match the conventions. Try renaming it to follow this pattern:

    type(JIRA-123)!: description
''',
          prNumber: prNumber,
        );
      }

      return ExitCode.tempFail.code;
    }

    validationProgress.complete(
      'The message follows the formatting conventions!',
    );
    return ExitCode.success.code;
  }
}
