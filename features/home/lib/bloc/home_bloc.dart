import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AppRouter router,
    required ThemeService themeService,
    required ConnectivityService connectivityService,
    required GetThemeModeUseCase getThemeMode,
  })  : _router = router,
        _themeService = themeService,
        _connectivityService = connectivityService,
        _getThemeMode = getThemeMode,
        super(const HomeState()) {
    on<HomeEvent>(
      (event, emit) => switch (event) {
        final _HomeInit e => _init(e, emit),
        final _ThemeModChanged e => _handleThemeModeChange(e, emit),
      },
    );

    _themeService.addListener(_themeModeListener);

    add(const _HomeInit());
  }

  final AppRouter _router;
  final ThemeService _themeService;
  final ConnectivityService _connectivityService;
  final GetThemeModeUseCase _getThemeMode;

  RouterConfig<UrlState> get routerConfig => _router.config();

  void _init(_HomeInit event, Emitter<HomeState> emit) {
    final themeMode = _getThemeMode.execute();

    emit(state.copyWith(themeMode: themeMode));
  }

  void _themeModeListener() => add(const _ThemeModChanged());

  void _handleThemeModeChange(
    _ThemeModChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(themeMode: _getThemeMode.execute()));
  }

  @override
  Future<void> close() {
    _themeService.removeListener(_themeModeListener);
    return super.close();
  }
}
