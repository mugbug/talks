part of '../profile_screen.dart';

class _ProfileInitialView extends StatelessWidget {
  const _ProfileInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Tap here'),
        onPressed: () {
          context.read<ProfileBloc>().add(
                ProfileButtonTapped(),
              );
        },
      ),
    );
  }
}
