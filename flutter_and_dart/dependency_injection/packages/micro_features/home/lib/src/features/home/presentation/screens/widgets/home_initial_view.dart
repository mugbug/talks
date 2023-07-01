part of '../home_screen.dart';

class _HomeInitialView extends StatelessWidget {
  const _HomeInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Tap here'),
        onPressed: () {
          context.read<HomeBloc>().add(
                HomeButtonTapped(),
              );
        },
      ),
    );
  }
}
