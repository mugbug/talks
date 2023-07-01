part of '../home_screen.dart';

class _HomeSuccessView extends StatelessWidget {
  const _HomeSuccessView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final HomeSuccess state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ['This', 'is', 'a', 'list', 'example', '🦄']
          .map((e) => Text(e))
          .toList(),
    );
  }
}
