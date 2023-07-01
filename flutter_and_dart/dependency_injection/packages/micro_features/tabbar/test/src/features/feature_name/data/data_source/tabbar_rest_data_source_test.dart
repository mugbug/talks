import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tabbar/src/features/tabbar/data/data_source/tabbar_rest_data_source.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock implements Client {}

class _FakeResponse extends Fake implements Response {}

void main() {
  group('TabbarRepository >', () {
    const fakeId = 123;
    final mockHttpClient = _MockHttpClient();
    late TabbarRestDataSource sut;

    setUp(() {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => _FakeResponse(),
      );
      sut = TabbarRestDataSource(
        client: mockHttpClient,
      );
    });

    test(
        'when fetchTabbar() is called'
        'then it should return an Entity instance', () async {
      final dto = await sut.fetch(id: fakeId);

      expect(dto.id, fakeId);
      expect(dto.name, 'Mocked result');
    });
  });
}
