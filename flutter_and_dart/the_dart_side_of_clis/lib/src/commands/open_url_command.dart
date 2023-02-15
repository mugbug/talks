import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:the_dart_side_of_clis/src/cli/cli.dart';

/// {@template open_url_command}
///
/// `the_dart_side_of_clis open_url`
/// Offers a toolkit for opening all sorts of urls on emulators,
/// simulators and physical devices
/// {@endtemplate}
class OpenUrlCommand extends Command<int> {
  /// {@macro open_url_command}
  OpenUrlCommand({
    Logger? logger,
    required this.xcrun,
  }) : _logger = logger ?? Logger() {
    argParser.addOption(
      'url',
      abbr: 'u',
      help: 'The url to be opened',
      mandatory: true,
    );
  }

  @override
  String get description => 'Offers a toolkit for opening all sorts of urls on '
      'emulators, simulators and physical devices';

  @override
  String get name => 'open_url';

  final Logger _logger;
  final XCRun xcrun;

  @override
  Future<int> run() async {
    // example: the_dart_side_of_clis open_url -u "shoebox://"
    final url = argResults?['url'] as String;

    final progress = _logger.progress('Launching $url');
    try {
      await xcrun.openUrl(url);
      progress.complete('Launched $url on iOS simulator');
      return ExitCode.success.code;
    } catch (e) {
      progress.fail('Error launching $url');
      return ExitCode.tempFail.code;
    }
  }
}
