import 'package:http/src/client.dart';
import 'package:tabbar/tabbar.dart';

class AppCompositionRoot implements TabbarExternalCompositionRoot {
  TabbarScreen makeTabbarScreen() {
    return TabbarCompositionRoot(
      externalCompositionRoot: this,
    ).makeScreen();
  }

  @override
  Client makeHttpClient() => Client();
}
