part of '../profile_screen.dart';

class _ProfileLoadingView extends StatelessWidget {
  const _ProfileLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
