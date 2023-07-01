import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:profile/src/features/profile/business_logic/use_case/profile_use_case.dart';
import 'package:profile/src/features/profile/presentation/bloc/profile_exception.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase _profileUseCase;

  ProfileBloc({
    required ProfileUseCase profileUseCase,
  })  : _profileUseCase = profileUseCase,
        super(ProfileInitial()) {
    on<ProfileButtonTapped>(_onProfileButtonTapped);
  }

  Future<void> _onProfileButtonTapped(
    ProfileButtonTapped event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final entity = await _profileUseCase.fetchProfile();

      emit(ProfileSuccess(name: entity.name));

    } catch (error, stackTrace) {
      emit(ProfileFailure());
    }
  }
}
