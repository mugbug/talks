import 'package:profile/src/features/profile/business_logic/use_case/profile_use_case.dart';
import 'package:profile/src/features/profile/data/data_source/profile_rest_data_source.dart';
import 'package:profile/src/features/profile/data/repositories/profile_repository.dart';
import 'package:profile/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:profile/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:http/http.dart';

/// The package that will start this module should implement this
/// abstract class returning the expected objects so we can use them here.
///
/// For instance:
/// ```dart
/// class AppCompositionRoot implements ProfileExternalCompositionRoot {
///   @override
///   Client makeHttpClient(); {
///     return Client();
///   }
/// }
/// ```
///
abstract class ProfileExternalCompositionRoot {
  Client makeHttpClient();
}

/// Use this class to create any object inside this module.
/// Avoid using the classes constructor directly since it'll require
/// passing a lot of parameters.
class ProfileCompositionRoot {
  ProfileCompositionRoot({
    required ProfileExternalCompositionRoot externalCompositionRoot,
  }) : _externalCompositionRoot = externalCompositionRoot;

  final ProfileExternalCompositionRoot _externalCompositionRoot;

  ProfileScreen makeScreen() {
    return ProfileScreen(bloc: makeBloc());
  }

  ProfileBloc makeBloc() {
    return ProfileBloc(
      profileUseCase: makeUseCase(),
    );
  }

  ProfileUseCase makeUseCase() {
    return ProfileUseCase(repository: makeRepository());
  }

  ProfileRepository makeRepository() {
    return ProfileRepository(
        profileRestDataSource: makeRestDataSource());
  }

  ProfileRestDataSource makeRestDataSource() {
    return ProfileRestDataSource(
      client: _externalCompositionRoot.makeHttpClient(),
    );
  }
}
