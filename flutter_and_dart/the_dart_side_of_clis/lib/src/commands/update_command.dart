import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:the_dart_side_of_clis/src/command_runner.dart';
import 'package:the_dart_side_of_clis/src/version.dart';

/// {@template update_command}
/// A command which updates the CLI.
/// {@endtemplate}
class UpdateCommand extends Command<int> {
  /// {@macro update_command}
  UpdateCommand({
    required Logger logger,
    PubUpdater? pubUpdater,
  })  : _logger = logger,
        _pubUpdater = pubUpdater ?? PubUpdater();

  final Logger _logger;
  final PubUpdater _pubUpdater;

  @override
  String get description => 'Update the CLI.';

  static const String commandName = 'update';

  @override
  String get name => commandName;

  @override
  Future<int> run() async {
    final updateCheckProgress = _logger.progress('Checking for updates');
    late final String latestVersion;
    try {
      latestVersion = await _pubUpdater.getLatestVersion(packageName);
    } catch (error) {
      updateCheckProgress.fail();
      _logger.err('$error');
      return ExitCode.software.code;
    }
    updateCheckProgress.complete('Checked for updates');

    final isUpToDate = packageVersion == latestVersion;
    if (isUpToDate) {
      _logger.info('CLI is already at the latest version.');
      return ExitCode.success.code;
    }

    final updateProgress = _logger.progress('Updating to $latestVersion');
    try {
      await _pubUpdater.update(packageName: packageName);
    } catch (error) {
      updateProgress.fail();
      _logger.err('$error');
      return ExitCode.software.code;
    }
    updateProgress.complete('Updated to $latestVersion');

    return ExitCode.success.code;
  }
}
