part of 'cli.dart';

class GitHub {
  GitHub(this._logger);

  final Logger _logger;

  Future<String> pullRequestAuthor({
    required String prNumber,
  }) async {
    final result = await _Cmd.run(
      'gh pr view $prNumber --json author --template {{.author.login}}',
      [],
      logger: _logger,
    );

    return result.outLines.first;
  }

  Future<void> commentOnPR({
    required String message,
    required String prNumber,
  }) async {
    const bodyFilePath = './tmp_review_body.txt';
    final bodyFile = File('./tmp_review_body.txt')
      ..createSync()
      ..writeAsStringSync(message);

    try {
      await _Cmd.run(
        'gh pr review $prNumber --comment --body-file $bodyFilePath',
        [],
        logger: _logger,
      );
    } catch (e) {
      rethrow;
    } finally {
      await bodyFile.delete();
    }
  }
}
