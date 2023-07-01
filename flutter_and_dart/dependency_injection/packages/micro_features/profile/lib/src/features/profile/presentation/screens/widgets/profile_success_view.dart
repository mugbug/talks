part of '../profile_screen.dart';

class _ProfileSuccessView extends StatelessWidget {
  const _ProfileSuccessView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ProfileSuccess state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ['This', 'is', 'a', 'list', 'example', '🦄']
          .map((e) => Text(e))
          .toList(),
    );
  }
}
