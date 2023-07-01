part of 'tabbar_bloc.dart';

@immutable
abstract class TabbarState extends Equatable {
  const TabbarState();
}

class TabbarInitial extends TabbarState {
  @override
  List<Object?> get props => [];
}

class TabbarLoading extends TabbarState {
  @override
  List<Object?> get props => [];
}

class TabbarFailure extends TabbarState {
  @override
  List<Object?> get props => [];
}

class TabbarSuccess extends TabbarState {
  final String name;

  const TabbarSuccess({required this.name});

  @override
  List<Object?> get props => [name];
}
