import 'package:home/src/features/home/business_logic/use_case/home_use_case.dart';
import 'package:home/src/features/home/data/repositories/home_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../fixtures/home_dto_fixture.dart';

class _MockHomeRepository extends Mock
    implements HomeRepository {}

void main() {
  group('HomeUseCase >', () {
    const fakeId = 123;
    final repositoryMock = _MockHomeRepository();
    late HomeUseCase sut;

    setUp(() {
      sut = HomeUseCase(repository: repositoryMock);
    });

    test(
        'when fetchHome() is called'
        'then it should return an Entity instance', () async {
      when(
        () => repositoryMock.fetch(id: any(named: 'id')),
      ).thenAnswer(
        (_) => Future.value(HomeDTOFixture.base()),
      );

      final entity = await sut.fetchHome();

      expect(entity.name, 'fake name');
    });
  });
}
