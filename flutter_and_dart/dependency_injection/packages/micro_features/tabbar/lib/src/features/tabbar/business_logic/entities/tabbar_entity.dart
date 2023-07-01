import 'package:equatable/equatable.dart';

class TabbarEntity extends Equatable {
  final String name;

  const TabbarEntity({
    required this.name,
  });

  @override
  List<Object?> get props => [
    name,
  ];
}
