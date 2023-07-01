import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tabbar_bloc.dart';

part 'widgets/tabbar_initial_view.dart';
part 'widgets/tabbar_loading_view.dart';
part 'widgets/tabbar_success_view.dart';

class TabbarScreen extends StatelessWidget {
  const TabbarScreen({
    super.key,
    required this.bloc,
  });

  final TabbarBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabbarBloc>.value(
      value: bloc,
      child: const TabbarView(),
    );
  }
}

class TabbarView extends StatelessWidget {
  const TabbarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tabbar')),
      body: BlocBuilder<TabbarBloc, TabbarState>(
        builder: (context, state) {
          if (state is TabbarLoading) {
            return const _TabbarLoadingView();
          }

          if (state is TabbarSuccess) {
            return _TabbarSuccessView(state: state);
          }

          return const _TabbarInitialView();
        },
      ),
    );
  }
}
