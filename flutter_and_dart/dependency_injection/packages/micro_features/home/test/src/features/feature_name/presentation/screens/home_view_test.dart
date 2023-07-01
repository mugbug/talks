import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:home/src/features/home/presentation/screens/home_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/pump_app.dart';

class _MockHomeBloc extends Mock implements HomeBloc {}

class _FakeHomeEvent extends Fake implements HomeEvent {}

void main() {
  group('HomeScreen >', () {
    final blocMock = _MockHomeBloc();

    setUp(() {
      registerFallbackValue(_FakeHomeEvent());
    });

    group('when in HomeInitial state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<HomeState>.fromIterable([]),
          initialState: HomeInitial(),
        );
      });

      testWidgets(
          'and button is tapped'
          'then [HomeButtonTapped] should be emitted',
          (tester) async {
        await tester.pumpApp(
          child: BlocProvider<HomeBloc>.value(
            value: blocMock,
            child: const HomeView(),
          ),
        );

        final button = find.byType(TextButton);
        expect(button, findsOneWidget);

        await tester.tap(button);
        await tester.pumpAndSettle();

        verify(() => blocMock.add(HomeButtonTapped())).called(1);
      });
    });
    group('when in HomeLoading state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<HomeState>.fromIterable([]),
          initialState: HomeLoading(),
        );
      });

      testWidgets('then should show a Spinner', (tester) async {
        await tester.pumpApp(
          child: BlocProvider<HomeBloc>.value(
            value: blocMock,
            child: const HomeView(),
          ),
        );

        final button = find.byType(CircularProgressIndicator);
        expect(button, findsOneWidget);
      });
    });

    group('when in HomeSuccess state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<HomeState>.fromIterable([]),
          initialState: const HomeSuccess(name: 'some fake name'),
        );
      });

      testWidgets('then should show a CozyAccordion', (tester) async {
        await tester.pumpApp(
          child: BlocProvider<HomeBloc>.value(
            value: blocMock,
            child: const HomeView(),
          ),
        );

        final button = find.byType(ListView);
        expect(button, findsOneWidget);
      });
    });
  });
}
