import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:profile/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/pump_app.dart';

class _MockProfileBloc extends Mock implements ProfileBloc {}

class _FakeProfileEvent extends Fake implements ProfileEvent {}

void main() {
  group('ProfileScreen >', () {
    final blocMock = _MockProfileBloc();

    setUp(() {
      registerFallbackValue(_FakeProfileEvent());
    });

    group('when in ProfileInitial state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<ProfileState>.fromIterable([]),
          initialState: ProfileInitial(),
        );
      });

      testWidgets(
          'and button is tapped'
          'then [ProfileButtonTapped] should be emitted',
          (tester) async {
        await tester.pumpApp(
          child: BlocProvider<ProfileBloc>.value(
            value: blocMock,
            child: const ProfileView(),
          ),
        );

        final button = find.byType(TextButton);
        expect(button, findsOneWidget);

        await tester.tap(button);
        await tester.pumpAndSettle();

        verify(() => blocMock.add(ProfileButtonTapped())).called(1);
      });
    });
    group('when in ProfileLoading state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<ProfileState>.fromIterable([]),
          initialState: ProfileLoading(),
        );
      });

      testWidgets('then should show a Spinner', (tester) async {
        await tester.pumpApp(
          child: BlocProvider<ProfileBloc>.value(
            value: blocMock,
            child: const ProfileView(),
          ),
        );

        final button = find.byType(CircularProgressIndicator);
        expect(button, findsOneWidget);
      });
    });

    group('when in ProfileSuccess state', () {
      setUp(() {
        whenListen(
          blocMock,
          Stream<ProfileState>.fromIterable([]),
          initialState: const ProfileSuccess(name: 'some fake name'),
        );
      });

      testWidgets('then should show a CozyAccordion', (tester) async {
        await tester.pumpApp(
          child: BlocProvider<ProfileBloc>.value(
            value: blocMock,
            child: const ProfileView(),
          ),
        );

        final button = find.byType(ListView);
        expect(button, findsOneWidget);
      });
    });
  });
}
