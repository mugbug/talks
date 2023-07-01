import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:home/src/features/home/data/data_source/home_rest_data_source.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock implements Client {}

class _FakeResponse extends Fake implements Response {}

void main() {
  group('HomeRepository >', () {
    const fakeId = 123;
    final mockHttpClient = _MockHttpClient();
    late HomeRestDataSource sut;

    setUp(() {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => _FakeResponse(),
      );
      sut = HomeRestDataSource(
        client: mockHttpClient,
      );
    });

    test(
        'when fetchHome() is called'
        'then it should return an Entity instance', () async {
      final dto = await sut.fetch(id: fakeId);

      expect(dto.id, fakeId);
      expect(dto.name, 'Mocked result');
    });
  });
}
