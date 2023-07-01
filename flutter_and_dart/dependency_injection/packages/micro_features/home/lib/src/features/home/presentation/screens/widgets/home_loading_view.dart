part of '../home_screen.dart';

class _HomeLoadingView extends StatelessWidget {
  const _HomeLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
