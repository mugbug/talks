part of 'cli.dart';

class XCRun {
  XCRun(this.logger);

  final Logger logger;

  Future<void> openUrl(String url) async {
    await _Cmd.run('xcrun simctl openurl booted "$url"', [], logger: logger);
  }
}
