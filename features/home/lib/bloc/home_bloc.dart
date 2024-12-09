import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';

import '../home.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AppRouter router,
    required ThemeService themeService,
    required ConnectivityService connectivityService,
    required GetThemeModeUseCase getThemeMode,
    required GetConnectionStatusUseCase getConnectivityStatus,
  })  : _router = router,
        _themeService = themeService,
        _connectivityService = connectivityService,
        _getThemeMode = getThemeMode,
        _getConnectivityStatus = getConnectivityStatus,
        super(const HomeState()) {
    on<HomeEvent>(
      (event, emit) => switch (event) {
        final _HomeInit e => _init(e, emit),
        final _ThemeModChanged e => _handleThemeModeChange(e, emit),
        final _ConnectionStatusChanged e =>
          _handleConnectionStatusChange(e, emit),
      },
    );

    _themeService.addListener(_themeModeListener);
    _connectivityService.addListener(_connectivityListener);

    add(const _HomeInit());
  }

  final AppRouter _router;
  final ThemeService _themeService;
  final ConnectivityService _connectivityService;
  final GetThemeModeUseCase _getThemeMode;
  final GetConnectionStatusUseCase _getConnectivityStatus;

  RouterConfig<UrlState> get routerConfig => _router.config();

  void _init(_HomeInit event, Emitter<HomeState> emit) {
    final themeMode = _getThemeMode.execute();

    emit(state.copyWith(themeMode: themeMode));
  }

  void _themeModeListener() => add(const _ThemeModChanged());
  void _connectivityListener() => add(const _ConnectionStatusChanged());

  void _handleThemeModeChange(_ThemeModChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(themeMode: _getThemeMode.execute()));
  }

  Future<void> _handleConnectionStatusChange(
    _ConnectionStatusChanged event,
    Emitter<HomeState> emit,
  ) async {
    final connected = _getConnectivityStatus.execute();
    if (connected) {
      if (_router.current.name == NoConnectionRoute.name) {
        await _router.maybePop();
      }
    } else {
      await _router.push(const NoConnectionRoute());
    }
  }

  @override
  Future<void> close() {
    _themeService.removeListener(_themeModeListener);
    _connectivityService.removeListener(_connectivityListener);

    return super.close();
  }
}
