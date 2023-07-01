import 'package:profile/src/features/profile/data/data_source/profile_rest_data_source.dart';
import 'package:profile/src/features/profile/data/repositories/profile_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../fixtures/profile_dto_fixture.dart';

class _MockProfileRestDataSource extends Mock
    implements ProfileRestDataSource {}

void main() {
  group('ProfileRepository >', () {
    const fakeId = 123;
    final mockProfileDataSource = _MockProfileRestDataSource();
    late ProfileRepository sut;

    setUp(() {
      sut = ProfileRepository(
        profileRestDataSource: mockProfileDataSource,
      );
    });

    test(
        'when fetchProfile() is called'
        'then it should return an Entity instance', () async {
      when(
        () => mockProfileDataSource.fetch(id: fakeId),
      ).thenAnswer(
        (_) => Future.value(ProfileDTOFixture.base()),
      );

      final dto = await sut.fetch(id: fakeId);

      expect(dto.name, 'fake name');
    });
  });
}
