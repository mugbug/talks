import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/src/features/profile/business_logic/use_case/profile_use_case.dart';
import 'package:profile/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:profile/src/features/profile/presentation/bloc/profile_exception.dart';

import '../../fixtures/profile_entity_fixture.dart';

class _MockProfileUseCase extends Mock implements ProfileUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
  });

  group('ProfileBloc >', () {
    final mockProfileUseCase = _MockProfileUseCase();

    final entityFixture = ProfileEntityFixture.base();
    late ProfileBloc sut;

    setUp(() {
      sut = ProfileBloc(
        profileUseCase: mockProfileUseCase,
      );
    });

    test('initial state is [ProfileInitial]', () {
      expect(sut.state, isA<ProfileInitial>());
    });

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileSuccess] '
      'when ProfileButtonTapped is added.',
      setUp: () {
        when(() => mockProfileUseCase.fetchProfile()).thenAnswer(
          (invocation) => Future.value(
            entityFixture,
          ),
        );
      },
      build: () => sut,
      act: (bloc) => bloc.add(ProfileButtonTapped()),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileSuccess(name: entityFixture.name),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [ProfileLoading, ProfileFailure] and records error'
      'when ProfileButtonTapped is added and fetch fails.',
      setUp: () {
        when(() => mockProfileUseCase.fetchProfile()).thenThrow(
          (invocation) => Future.value(
            const ProfileButtonTappedException('HTTP failed - 503'),
          ),
        );
      },
      build: () => sut,
      act: (bloc) => bloc.add(ProfileButtonTapped()),
      expect: () => <ProfileState>[
        ProfileLoading(),
        ProfileFailure(),
      ],
    );
  });
}
