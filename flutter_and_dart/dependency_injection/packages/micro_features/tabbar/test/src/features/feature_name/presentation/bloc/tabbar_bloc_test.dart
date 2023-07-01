import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tabbar/src/features/tabbar/business_logic/use_case/tabbar_use_case.dart';
import 'package:tabbar/src/features/tabbar/presentation/bloc/tabbar_bloc.dart';
import 'package:tabbar/src/features/tabbar/presentation/bloc/tabbar_exception.dart';

import '../../fixtures/tabbar_entity_fixture.dart';

class _MockTabbarUseCase extends Mock implements TabbarUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
  });

  group('TabbarBloc >', () {
    final mockTabbarUseCase = _MockTabbarUseCase();

    final entityFixture = TabbarEntityFixture.base();
    late TabbarBloc sut;

    setUp(() {
      sut = TabbarBloc(
        tabbarUseCase: mockTabbarUseCase,
      );
    });

    test('initial state is [TabbarInitial]', () {
      expect(sut.state, isA<TabbarInitial>());
    });

    blocTest<TabbarBloc, TabbarState>(
      'emits [TabbarLoading, TabbarSuccess] '
      'when TabbarButtonTapped is added.',
      setUp: () {
        when(() => mockTabbarUseCase.fetchTabbar()).thenAnswer(
          (invocation) => Future.value(
            entityFixture,
          ),
        );
      },
      build: () => sut,
      act: (bloc) => bloc.add(TabbarButtonTapped()),
      expect: () => <TabbarState>[
        TabbarLoading(),
        TabbarSuccess(name: entityFixture.name),
      ],
    );

    blocTest<TabbarBloc, TabbarState>(
      'emits [TabbarLoading, TabbarFailure] and records error'
      'when TabbarButtonTapped is added and fetch fails.',
      setUp: () {
        when(() => mockTabbarUseCase.fetchTabbar()).thenThrow(
          (invocation) => Future.value(
            const TabbarButtonTappedException('HTTP failed - 503'),
          ),
        );
      },
      build: () => sut,
      act: (bloc) => bloc.add(TabbarButtonTapped()),
      expect: () => <TabbarState>[
        TabbarLoading(),
        TabbarFailure(),
      ],
    );
  });
}
