part of '../tabbar_screen.dart';

class _TabbarInitialView extends StatelessWidget {
  const _TabbarInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Tap here'),
        onPressed: () {
          context.read<TabbarBloc>().add(
                TabbarButtonTapped(),
              );
        },
      ),
    );
  }
}
