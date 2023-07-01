import 'package:tabbar/src/features/tabbar/data/data_source/tabbar_rest_data_source.dart';
import 'package:tabbar/src/features/tabbar/data/repositories/tabbar_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../fixtures/tabbar_dto_fixture.dart';

class _MockTabbarRestDataSource extends Mock
    implements TabbarRestDataSource {}

void main() {
  group('TabbarRepository >', () {
    const fakeId = 123;
    final mockTabbarDataSource = _MockTabbarRestDataSource();
    late TabbarRepository sut;

    setUp(() {
      sut = TabbarRepository(
        tabbarRestDataSource: mockTabbarDataSource,
      );
    });

    test(
        'when fetchTabbar() is called'
        'then it should return an Entity instance', () async {
      when(
        () => mockTabbarDataSource.fetch(id: fakeId),
      ).thenAnswer(
        (_) => Future.value(TabbarDTOFixture.base()),
      );

      final dto = await sut.fetch(id: fakeId);

      expect(dto.name, 'fake name');
    });
  });
}
