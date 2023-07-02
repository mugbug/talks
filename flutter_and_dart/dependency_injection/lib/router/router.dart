import 'package:dependency_injection/di/app_composition_root.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorHomeKey = GlobalKey<NavigatorState>(
    debugLabel: 'shell_home',
  );
  final shellNavigatorProfileKey = GlobalKey<NavigatorState>(
    debugLabel: 'shell_profile',
  );

  return GoRouter(
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppCompositionRoot().makeTabbarScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: AppCompositionRoot().makeHomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: AppCompositionRoot().makeProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    observers: [RedirectToHomeObserver()],
  );
}

class RedirectToHomeObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (previousRoute == null && route.settings.name != '/home') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = route.navigator!.context;
        GoRouter.of(context).go('/home');
      });
    }
  }
}
