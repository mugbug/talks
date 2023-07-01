import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tabbar/src/features/tabbar/business_logic/use_case/tabbar_use_case.dart';
import 'package:tabbar/src/features/tabbar/presentation/bloc/tabbar_exception.dart';

part 'tabbar_event.dart';
part 'tabbar_state.dart';

class TabbarBloc extends Bloc<TabbarEvent, TabbarState> {
  final TabbarUseCase _tabbarUseCase;

  TabbarBloc({
    required TabbarUseCase tabbarUseCase,
  })  : _tabbarUseCase = tabbarUseCase,
        super(TabbarInitial()) {
    on<TabbarButtonTapped>(_onTabbarButtonTapped);
  }

  Future<void> _onTabbarButtonTapped(
    TabbarButtonTapped event,
    Emitter<TabbarState> emit,
  ) async {
    emit(TabbarLoading());

    try {
      final entity = await _tabbarUseCase.fetchTabbar();

      emit(TabbarSuccess(name: entity.name));

    } catch (error, stackTrace) {
      emit(TabbarFailure());
    }
  }
}
