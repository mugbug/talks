part of '../tabbar_screen.dart';

class _TabbarSuccessView extends StatelessWidget {
  const _TabbarSuccessView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final TabbarSuccess state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ['This', 'is', 'a', 'list', 'example', '🦄']
          .map((e) => Text(e))
          .toList(),
    );
  }
}
