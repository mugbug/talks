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
  }) : _logger = logger ?? Logger() {
    // TODO: add the command arguments here
    argParser.addFlag(
      'cyan',
      abbr: 'c',
      help: 'Prints the same joke, but in cyan',
      negatable: false,
    );
  }

  @override
  String get description => 'Shows the content of the presentation this CLI was created for';

  @override
  String get name => 'talk';

  final Logger _logger;

  @override
  Future<int> run() async {
    // TODO: for logging we use mason_logger: https://pub.dev/packages/mason_logger
    var output = 'Which unicorn has a cold? The Achoo-nicorn!';
    if (argResults?['cyan'] == true) {
      output = lightCyan.wrap(output)!;
    }
    _logger.info(output);

    final progress = _logger.progress('Trying to understand the joke');
    await Future.delayed(const Duration(seconds: 1));
    progress.complete('kkkk nice');

    // TODO: we can use some custom CLI here like [GitHub] or [Fastlane]
    // that we can find/create on the `cli/` folder
    return ExitCode.success.code;
  }
}
