import 'package:tabbar/src/features/tabbar/business_logic/use_case/tabbar_use_case.dart';
import 'package:tabbar/src/features/tabbar/data/data_source/tabbar_rest_data_source.dart';
import 'package:tabbar/src/features/tabbar/data/repositories/tabbar_repository.dart';
import 'package:tabbar/src/features/tabbar/presentation/bloc/tabbar_bloc.dart';
import 'package:tabbar/src/features/tabbar/presentation/screens/tabbar_screen.dart';
import 'package:http/http.dart';

/// The package that will start this module should implement this
/// abstract class returning the expected objects so we can use them here.
///
/// For instance:
/// ```dart
/// class AppCompositionRoot implements TabbarExternalCompositionRoot {
///   @override
///   Client makeHttpClient(); {
///     return Client();
///   }
/// }
/// ```
///
abstract class TabbarExternalCompositionRoot {
  Client makeHttpClient();
}

/// Use this class to create any object inside this module.
/// Avoid using the classes constructor directly since it'll require
/// passing a lot of parameters.
class TabbarCompositionRoot {
  TabbarCompositionRoot({
    required TabbarExternalCompositionRoot externalCompositionRoot,
  }) : _externalCompositionRoot = externalCompositionRoot;

  final TabbarExternalCompositionRoot _externalCompositionRoot;

  TabbarScreen makeScreen() {
    return TabbarScreen(bloc: makeBloc());
  }

  TabbarBloc makeBloc() {
    return TabbarBloc(
      tabbarUseCase: makeUseCase(),
    );
  }

  TabbarUseCase makeUseCase() {
    return TabbarUseCase(repository: makeRepository());
  }

  TabbarRepository makeRepository() {
    return TabbarRepository(
        tabbarRestDataSource: makeRestDataSource());
  }

  TabbarRestDataSource makeRestDataSource() {
    return TabbarRestDataSource(
      client: _externalCompositionRoot.makeHttpClient(),
    );
  }
}
