import 'package:equatable/equatable.dart';

abstract class HomeException extends Equatable implements Exception {
  final String description;

  const HomeException(this.description);
  
  @override
  List<String?> get props => [description];

  @override
  String toString() => '$runtimeType($description)';
}

class HomeButtonTappedException extends HomeException {
  const HomeButtonTappedException(super.description);
  
  @override
  List<String?> get props => [description];
}
