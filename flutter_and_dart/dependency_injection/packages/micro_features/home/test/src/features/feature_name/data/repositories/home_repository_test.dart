import 'package:home/src/features/home/data/data_source/home_rest_data_source.dart';
import 'package:home/src/features/home/data/repositories/home_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../fixtures/home_dto_fixture.dart';

class _MockHomeRestDataSource extends Mock
    implements HomeRestDataSource {}

void main() {
  group('HomeRepository >', () {
    const fakeId = 123;
    final mockHomeDataSource = _MockHomeRestDataSource();
    late HomeRepository sut;

    setUp(() {
      sut = HomeRepository(
        homeRestDataSource: mockHomeDataSource,
      );
    });

    test(
        'when fetchHome() is called'
        'then it should return an Entity instance', () async {
      when(
        () => mockHomeDataSource.fetch(id: fakeId),
      ).thenAnswer(
        (_) => Future.value(HomeDTOFixture.base()),
      );

      final dto = await sut.fetch(id: fakeId);

      expect(dto.name, 'fake name');
    });
  });
}
