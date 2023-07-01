import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String name;

  const HomeEntity({
    required this.name,
  });

  @override
  List<Object?> get props => [
    name,
  ];
}
