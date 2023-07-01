import 'package:equatable/equatable.dart';

abstract class ProfileException extends Equatable implements Exception {
  final String description;

  const ProfileException(this.description);
  
  @override
  List<String?> get props => [description];

  @override
  String toString() => '$runtimeType($description)';
}

class ProfileButtonTappedException extends ProfileException {
  const ProfileButtonTappedException(super.description);
  
  @override
  List<String?> get props => [description];
}
