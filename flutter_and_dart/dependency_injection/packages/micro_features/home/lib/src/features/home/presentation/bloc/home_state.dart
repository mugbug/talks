part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFailure extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  final String name;

  const HomeSuccess({required this.name});

  @override
  List<Object?> get props => [name];
}
