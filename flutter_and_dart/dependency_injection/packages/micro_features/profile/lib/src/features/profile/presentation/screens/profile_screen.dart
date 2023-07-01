import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';

part 'widgets/profile_initial_view.dart';
part 'widgets/profile_loading_view.dart';
part 'widgets/profile_success_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.bloc,
  });

  final ProfileBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>.value(
      value: bloc,
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const _ProfileLoadingView();
          }

          if (state is ProfileSuccess) {
            return _ProfileSuccessView(state: state);
          }

          return const _ProfileInitialView();
        },
      ),
    );
  }
}
