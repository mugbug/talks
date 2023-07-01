import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:home/src/features/home/business_logic/use_case/home_use_case.dart';
import 'package:home/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:home/src/features/home/presentation/bloc/home_exception.dart';

import '../../fixtures/home_entity_fixture.dart';

class _MockHomeUseCase extends Mock implements HomeUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
  });

  group('HomeBloc >', () {
    final mockHomeUseCase = _MockHomeUseCase();

    final entityFixture = HomeEntityFixture.base();
    late HomeBloc sut;

    setUp(() {
      sut = HomeBloc(
        homeUseCase: mockHomeUseCase,
      );
    });

    test('initial state is [HomeInitial]', () {
      expect(sut.state, isA<HomeInitial>());
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeSuccess] '
      'when HomeButtonTapped is added.',
      setUp: () {
        when(() => mockHomeUseCase.fetchHome()).thenAnswer(
          (invocation) => Future.value(
            entityFixture,
          ),
        );
      },
      build: () => sut,
      act: (bloc) => bloc.add(HomeButtonTapped()),
      expect: () => <HomeState>[
        HomeLoading(),
        HomeSuccess(name: entityFixture.name),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeFailure] and records error'
      'when HomeButtonTapped is added and fetch fails.',
      setUp: () {
        when(() => mockHomeUseCase.fetchHome()).thenThrow(
          (invocation) => Future.value(
            const HomeButtonTappedException('HTTP failed - 503'),
          ),
        );
      },
      build: () => sut,
      act: (bloc) => bloc.add(HomeButtonTapped()),
      expect: () => <HomeState>[
        HomeLoading(),
        HomeFailure(),
      ],
    );
  });
}
