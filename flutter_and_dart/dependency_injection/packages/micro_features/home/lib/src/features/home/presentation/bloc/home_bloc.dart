import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:home/src/features/home/business_logic/use_case/home_use_case.dart';
import 'package:home/src/features/home/presentation/bloc/home_exception.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;

  HomeBloc({
    required HomeUseCase homeUseCase,
  })  : _homeUseCase = homeUseCase,
        super(HomeInitial()) {
    on<HomeButtonTapped>(_onHomeButtonTapped);
  }

  Future<void> _onHomeButtonTapped(
    HomeButtonTapped event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final entity = await _homeUseCase.fetchHome();

      emit(HomeSuccess(name: entity.name));

    } catch (error, stackTrace) {
      emit(HomeFailure());
    }
  }
}
