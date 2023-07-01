part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileButtonTapped extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
