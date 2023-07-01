import 'package:home/src/features/home/business_logic/use_case/home_use_case.dart';
import 'package:home/src/features/home/data/data_source/home_rest_data_source.dart';
import 'package:home/src/features/home/data/repositories/home_repository.dart';
import 'package:home/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:home/src/features/home/presentation/screens/home_screen.dart';
import 'package:http/http.dart';

/// The package that will start this module should implement this
/// abstract class returning the expected objects so we can use them here.
///
/// For instance:
/// ```dart
/// class AppCompositionRoot implements HomeExternalCompositionRoot {
///   @override
///   Client makeHttpClient(); {
///     return Client();
///   }
/// }
/// ```
///
abstract class HomeExternalCompositionRoot {
  Client makeHttpClient();
}

/// Use this class to create any object inside this module.
/// Avoid using the classes constructor directly since it'll require
/// passing a lot of parameters.
class HomeCompositionRoot {
  HomeCompositionRoot({
    required HomeExternalCompositionRoot externalCompositionRoot,
  }) : _externalCompositionRoot = externalCompositionRoot;

  final HomeExternalCompositionRoot _externalCompositionRoot;

  HomeScreen makeScreen() {
    return HomeScreen(bloc: makeBloc());
  }

  HomeBloc makeBloc() {
    return HomeBloc(
      homeUseCase: makeUseCase(),
    );
  }

  HomeUseCase makeUseCase() {
    return HomeUseCase(repository: makeRepository());
  }

  HomeRepository makeRepository() {
    return HomeRepository(
        homeRestDataSource: makeRestDataSource());
  }

  HomeRestDataSource makeRestDataSource() {
    return HomeRestDataSource(
      client: _externalCompositionRoot.makeHttpClient(),
    );
  }
}
