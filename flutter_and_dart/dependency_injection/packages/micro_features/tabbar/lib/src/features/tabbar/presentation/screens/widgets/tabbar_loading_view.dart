part of '../tabbar_screen.dart';

class _TabbarLoadingView extends StatelessWidget {
  const _TabbarLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
