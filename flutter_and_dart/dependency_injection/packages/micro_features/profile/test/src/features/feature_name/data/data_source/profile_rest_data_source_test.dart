import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/src/features/profile/data/data_source/profile_rest_data_source.dart';
import 'package:test/test.dart';

class _MockHttpClient extends Mock implements Client {}

class _FakeResponse extends Fake implements Response {}

void main() {
  group('ProfileRepository >', () {
    const fakeId = 123;
    final mockHttpClient = _MockHttpClient();
    late ProfileRestDataSource sut;

    setUp(() {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => _FakeResponse(),
      );
      sut = ProfileRestDataSource(
        client: mockHttpClient,
      );
    });

    test(
        'when fetchProfile() is called'
        'then it should return an Entity instance', () async {
      final dto = await sut.fetch(id: fakeId);

      expect(dto.id, fakeId);
      expect(dto.name, 'Mocked result');
    });
  });
}
