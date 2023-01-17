import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

// TODO: add this command as a subcommand to TheDartSideOfClisCommandRunner or another
// For more info, check this docs: https://pub.dev/packages/args

/// {@template talk_command}
///
/// `the_dart_side_of_clis talk`
/// Shows the content of the presentation this CLI was created for
/// {@endtemplate}
class TalkCommand extends Command<int> {
  /// {@macro talk_command}
  TalkCommand({
    Logger? logger,
  }) : _logger = logger ?? Logger();

  @override
  String get description =>
      'Shows the content of the presentation this CLI was created for';

  @override
  String get name => 'talk';

  final Logger _logger;

  @override
  Future<int> run() async {
    final result = await Process.run(
      'pwd',
      [],
    );

    _logger.info(result.stdout.toString());

    final presentationFile = File(
      path.join(
        'lib',
        'src',
        'slides',
        'full_presentation.md',
      ),
    );

    final fullPresentation = await presentationFile.readAsString();

    final slides = fullPresentation.split('---')
      ..removeAt(0)
      ..removeAt(0);

    await clearTerminal();

    for (final slide in slides) {
      _logger
        ..success(slide)
        ..prompt('>');
      await clearTerminal();
    }

    _logger.progress("That's all folks, thanks!").complete();

    return ExitCode.success.code;
  }

  Future<void> clearTerminal() async {
    final clearCommand = Platform.isWindows ? 'cls' : 'clear';

    final result = await Process.run(clearCommand, [], runInShell: true);
    _logger.info(result.stdout.toString());
  }
}
