import 'package:tabbar/src/features/tabbar/business_logic/use_case/tabbar_use_case.dart';
import 'package:tabbar/src/features/tabbar/data/repositories/tabbar_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../fixtures/tabbar_dto_fixture.dart';

class _MockTabbarRepository extends Mock
    implements TabbarRepository {}

void main() {
  group('TabbarUseCase >', () {
    const fakeId = 123;
    final repositoryMock = _MockTabbarRepository();
    late TabbarUseCase sut;

    setUp(() {
      sut = TabbarUseCase(repository: repositoryMock);
    });

    test(
        'when fetchTabbar() is called'
        'then it should return an Entity instance', () async {
      when(
        () => repositoryMock.fetch(id: any(named: 'id')),
      ).thenAnswer(
        (_) => Future.value(TabbarDTOFixture.base()),
      );

      final entity = await sut.fetchTabbar();

      expect(entity.name, 'fake name');
    });
  });
}
