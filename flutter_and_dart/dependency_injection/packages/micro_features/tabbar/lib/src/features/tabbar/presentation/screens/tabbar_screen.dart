import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/tabbar_bloc.dart';

part 'widgets/tabbar_initial_view.dart';
part 'widgets/tabbar_loading_view.dart';
part 'widgets/tabbar_success_view.dart';

class TabbarScreen extends StatelessWidget {
  const TabbarScreen({
    super.key,
    required this.bloc,
    required this.navigationShell,
  });

  final TabbarBloc bloc;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabbarBloc>.value(
      value: bloc,
      child: TabbarView(
        navigationShell: navigationShell,
      ),
    );
  }
}

class TabbarView extends StatelessWidget {
  const TabbarView({
    super.key = const ValueKey('TabbarView'),
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
