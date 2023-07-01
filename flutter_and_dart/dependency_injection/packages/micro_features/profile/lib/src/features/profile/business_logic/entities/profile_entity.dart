import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String name;

  const ProfileEntity({
    required this.name,
  });

  @override
  List<Object?> get props => [
    name,
  ];
}
