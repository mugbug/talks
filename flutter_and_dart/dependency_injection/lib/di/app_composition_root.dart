import 'package:go_router/go_router.dart';
import 'package:home/home.dart';
import 'package:http/http.dart';
import 'package:profile/profile.dart';
import 'package:tabbar/tabbar.dart';

class AppCompositionRoot
    implements
        TabbarExternalCompositionRoot,
        HomeExternalCompositionRoot,
        ProfileExternalCompositionRoot {
  TabbarScreen makeTabbarScreen({
    required StatefulNavigationShell navigationShell,
  }) {
    return TabbarCompositionRoot(
      externalCompositionRoot: this,
    ).makeScreen(navigationShell: navigationShell);
  }

  HomeScreen makeHomeScreen() {
    return HomeCompositionRoot(externalCompositionRoot: this).makeScreen();
  }

  ProfileScreen makeProfileScreen() {
    return ProfileCompositionRoot(externalCompositionRoot: this).makeScreen();
  }

  @override
  Client makeHttpClient() => Client();
}
