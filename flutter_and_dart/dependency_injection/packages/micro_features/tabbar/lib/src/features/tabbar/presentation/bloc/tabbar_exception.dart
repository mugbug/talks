import 'package:equatable/equatable.dart';

abstract class TabbarException extends Equatable implements Exception {
  final String description;

  const TabbarException(this.description);
  
  @override
  List<String?> get props => [description];

  @override
  String toString() => '$runtimeType($description)';
}

class TabbarButtonTappedException extends TabbarException {
  const TabbarButtonTappedException(super.description);
  
  @override
  List<String?> get props => [description];
}
