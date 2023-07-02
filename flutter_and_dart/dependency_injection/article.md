# Dependency Injection in Dart/Flutter

## Background & motivation
It's hard to find a well structured solution for dependency injection that doesn't use a service locator approach.
To use a service locator tool as main dependency injection solution, we need a well structured solution, linters, etc

## The issue with current most adopted solutions
Service locator
Requires an implicit order when registering the dependencies
Scaling, maintenance

## Composition Root
todo: link references

```mermaid
flowchart TD
    App --> Tabbar
    Tabbar --> Home
    Tabbar --> Profile
    App --> HttpClient
    Tabbar --> HttpClient
    Home --> HttpClient
    Profile --> HttpClient
```

```dart
// root module
class AppCompositionRoot implements TabBarExternalCompositionRoot {
  HttpClient makeHttpClient() => HttpClient();

  TabBarFeature makeTabBar() => TabBarFeature(dependencies: this);
}

// tabbar module
abstract class TabBarExternalCompositionRoot implements HomeExternalCompositionRoot {

}

class TabBarCompositionRoot {
  TabBarCompositionRoot({
    required this.dependencies,
  });

  final TabBarExternalCompositionRoot dependencies;

  Home makeHome() => Home(dependencies: dependencies);
}

// home module
abstract class HomeExternalCompositionRoot {
  HttpClient makeHttpClient();
}

class HomeCompositionRoot {
  HomeCompositionRoot({
    required this.dependencies,
  });
  
  final HomeExternalCompositionRoot dependencies;

  HomeScreen makeScreen() => HomeScreen(bloc: makeBloc());

  HomeBloc makeBloc() => HomeBloc(
    httpClient: dependencies.makeHttpClient(),
    otherDependencies: makeDeps(),
  );

  // ...
}
```