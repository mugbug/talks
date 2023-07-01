import 'package:profile/src/features/profile/business_logic/use_case/profile_use_case.dart';
import 'package:profile/src/features/profile/data/repositories/profile_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../fixtures/profile_dto_fixture.dart';

class _MockProfileRepository extends Mock
    implements ProfileRepository {}

void main() {
  group('ProfileUseCase >', () {
    const fakeId = 123;
    final repositoryMock = _MockProfileRepository();
    late ProfileUseCase sut;

    setUp(() {
      sut = ProfileUseCase(repository: repositoryMock);
    });

    test(
        'when fetchProfile() is called'
        'then it should return an Entity instance', () async {
      when(
        () => repositoryMock.fetch(id: any(named: 'id')),
      ).thenAnswer(
        (_) => Future.value(ProfileDTOFixture.base()),
      );

      final entity = await sut.fetchProfile();

      expect(entity.name, 'fake name');
    });
  });
}
