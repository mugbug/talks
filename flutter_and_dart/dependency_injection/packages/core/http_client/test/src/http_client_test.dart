// ignore_for_file: prefer_const_constructors
import 'package:http_client/http_client.dart';
import 'package:test/test.dart';

void main() {
  group('HttpClient', () {
    test('can be instantiated', () {
      expect(HttpClient(), isNotNull);
    });
  });
}
