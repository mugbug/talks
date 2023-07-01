import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabbar/src/features/tabbar/presentation/bloc/tabbar_bloc.dart';
import 'package:tabbar/src/features/tabbar/presentation/screens/tabbar_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/pump_app.dart';

class _MockTabbarBloc extends Mock implements TabbarBloc {}

class _FakeTabbarEvent extends Fake implements TabbarEvent {}

void main() {
  group('TabbarScreen >', () {
    final blocMock = _MockTabbarBloc();

    setUp(() {
      registerFallbackValue(_FakeTabbarEvent());
    });

    group('when in TabbarInitial state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<TabbarState>.fromIterable([]),
          initialState: TabbarInitial(),
        );
      });

      testWidgets(
          'and button is tapped'
          'then [TabbarButtonTapped] should be emitted',
          (tester) async {
        await tester.pumpApp(
          child: BlocProvider<TabbarBloc>.value(
            value: blocMock,
            child: const TabbarView(),
          ),
        );

        final button = find.byType(TextButton);
        expect(button, findsOneWidget);

        await tester.tap(button);
        await tester.pumpAndSettle();

        verify(() => blocMock.add(TabbarButtonTapped())).called(1);
      });
    });
    group('when in TabbarLoading state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<TabbarState>.fromIterable([]),
          initialState: TabbarLoading(),
        );
      });

      testWidgets('then should show a Spinner', (tester) async {
        await tester.pumpApp(
          child: BlocProvider<TabbarBloc>.value(
            value: blocMock,
            child: const TabbarView(),
          ),
        );

        final button = find.byType(CircularProgressIndicator);
        expect(button, findsOneWidget);
      });
    });

    group('when in TabbarSuccess state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<TabbarState>.fromIterable([]),
          initialState: const TabbarSuccess(name: 'some fake name'),
        );
      });

      testWidgets('then should show a CozyAccordion', (tester) async {
        await tester.pumpApp(
          child: BlocProvider<TabbarBloc>.value(
            value: blocMock,
            child: const TabbarView(),
          ),
        );

        final button = find.byType(ListView);
        expect(button, findsOneWidget);
      });
    });
  });
}
