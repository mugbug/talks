// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:process_run/shell.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:the_dart_side_of_clis/src/cli/cli.dart';
import 'package:the_dart_side_of_clis/src/command_runner.dart';

class _MockGitHub extends Mock implements GitHub {}

class _MockXCRun extends Mock implements XCRun {}

class _MockLogger extends Mock implements Logger {}

class _MockProgress extends Mock implements Progress {}

class _MockPubUpdater extends Mock implements PubUpdater {}

class _MockShell extends Mock implements Shell {}

class _MockProcessResult extends Mock implements ProcessResult {}

class MockContainer {
  MockContainer({
    required this.logger,
    required this.progress,
    required this.pubUpdater,
    required this.github,
    required this.xcrun,
  });

  final _MockGitHub github;
  final _MockXCRun xcrun;
  final _MockLogger logger;
  final _MockProgress progress;
  final _MockPubUpdater pubUpdater;
}

typedef WithRunnerCallback = FutureOr<void> Function(
  TheDartSideOfClisCommandRunner commandRunner,
  MockContainer mocks,
);

Future<void> withRunner(
  WithRunnerCallback runnerFn,
) async {
    final mocks = MockContainer(
      logger: _MockLogger(),
      progress: _MockProgress(),
      pubUpdater: _MockPubUpdater(),
      github: _MockGitHub(),
      xcrun: _MockXCRun(),
    );

    final commandRunner = TheDartSideOfClisCommandRunner(
      logger: mocks.logger,
      pubUpdater: mocks.pubUpdater,
      github: mocks.github,
      xcrun: mocks.xcrun,
    );

    when(() => mocks.logger.progress(any())).thenReturn(mocks.progress);
    when(() => mocks.logger.confirm(any())).thenReturn(true);
    when(
      () => mocks.pubUpdater.isUpToDate(
        packageName: any(named: 'packageName'),
        currentVersion: any(named: 'currentVersion'),
      ),
    ).thenAnswer((_) => Future.value(true));

    await runnerFn(
      commandRunner,
      mocks,
    );
}

/// Stream that will emit commands called by the shell.
typedef ShellListener = Stream<String>;

/// Callback that will be called on [withShell] with the list of commands called
/// after the shell mock setup is finished
typedef WithShellListenerCallback = FutureOr<void> Function(
  ShellListener shellListener,
  ProcessResult processResult,
  Logger logger,
);

Future<void> withShell(
  WithShellListenerCallback runnerFn,
) async {
  final commandsStreamController = StreamController<String>();
  final processResult = _MockProcessResult();
  final mockShell = _MockShell();
  final logger = _MockLogger();

  when(() => processResult.exitCode).thenReturn(ExitCode.success.code);
  when(
    () => mockShell.run(
      any(),
      onProcess: any(named: 'onProcess'),
    ),
  ).thenAnswer((invocation) async {
    final firstArg = invocation.positionalArguments.first;
    if (firstArg is String) {
      commandsStreamController.add(firstArg);
    }

    return [processResult];
  });

  when(() => logger.err(any())).thenReturn(null);
  when(() => logger.detail(any())).thenReturn(null);

  await ProcessOverrides.runZoned(
    () async {
      await runnerFn(
        commandsStreamController.stream,
        processResult,
        logger,
      );
    },
    shell: mockShell,
  );
}
