import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:equatable/equatable.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/shell.dart';
// import 'package:process_run/shell.dart';

part 'github_cli.dart';

const _asyncRunZoned = runZoned;

/// This class facilitates overriding [Process.run].
/// It should be extended by another class in client code with overrides
/// that construct a custom implementation.
@visibleForTesting
abstract class ProcessOverrides {
  static final _token = Object();

  /// Returns the current [ProcessOverrides] instance.
  ///
  /// This will return `null` if the current [Zone] does not contain
  /// any [ProcessOverrides].
  ///
  /// See also:
  /// * [ProcessOverrides.runZoned] to provide [ProcessOverrides]
  /// in a fresh [Zone].
  ///
  static ProcessOverrides? get current {
    return Zone.current[_token] as ProcessOverrides?;
  }

  /// Runs [body] in a fresh [Zone] using the provided overrides.
  static R runZoned<R>(
    R Function() body, {
    Shell? shell,
  }) {
    final overrides = _ProcessOverridesScope(shell);
    return _asyncRunZoned(body, zoneValues: {_token: overrides});
  }

  /// The Shell used to run a command.
  Shell get shell {
    throw Exception('You forgot to override a RunProcess');
  }
}

class _ProcessOverridesScope extends ProcessOverrides {
  _ProcessOverridesScope(this._shell);

  final ProcessOverrides? _previous = ProcessOverrides.current;
  final Shell? _shell;

  @override
  Shell get shell {
    return _shell ?? _previous?.shell ?? super.shell;
  }
}

/// Abstraction for running commands via command-line.
class _Cmd {
  /// Runs the specified [cmd] with the provided [args].
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    bool throwOnError = true,
    String? workingDirectory,
    required Logger logger,
  }) async {
    final outputController = ShellLinesController();
    final errController = ShellLinesController();

    final command = '$cmd ${args.join(' ')}'.trimRight();
    logger.detail('Running $command');
    final defaultShell = Shell(
      workingDirectory: workingDirectory,
      stdout: outputController.sink,
      stderr: errController.sink,
      verbose: false,
      throwOnError: throwOnError,
      runInShell: true,
    );

    outputController.stream.listen((message) {
      logger.detail('[INFO] $message');
    });

    errController.stream.listen((error) {
      logger.detail('[FAILURE] $error');
    });

    final shell = ProcessOverrides.current?.shell ?? defaultShell;

    final resultList = await shell.run(command);

    final result = resultList.last;

    if (throwOnError) {
      _throwIfProcessFailed(result, cmd, args, logger);
    }
    return result;
  }

  static void _throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
    Logger? logger,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        '[INFO]': pr.stdout.toString().trim(),
        '[FAILURE]': pr.stderr.toString().trim()
      }..removeWhere((k, v) => v.isEmpty);

      var message = 'Unknown error';
      if (values.isNotEmpty) {
        message = values.entries.map((e) => '${e.key}\n${e.value}').join('\n');
      }

      logger?.err(message);

      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}
