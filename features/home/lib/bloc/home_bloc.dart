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
    required ListenThemeModeUseCase getThemeMode,
    required GetConnectionStatusUseCase getConnectivityStatus,
  })  : _router = router,
        _listenThemeMode = getThemeMode,
        _listenConnectionStatus = getConnectivityStatus,
        super(const HomeState()) {
    on<HomeEvent>(
      (event, emit) => switch (event) {
        final _HomeInit e => _init(e, emit),
        final _ThemeModeChanged e => _handleThemeModeChange(e, emit),
        final _ConnectionStatusChanged e =>
          _handleConnectionStatusChange(e, emit),
      },
    );

    add(const _HomeInit());
  }

  final AppRouter _router;
  final ListenThemeModeUseCase _listenThemeMode;
  final GetConnectionStatusUseCase _listenConnectionStatus;

  RouterConfig<UrlState> get routerConfig => _router.config();

  void _init(_HomeInit event, Emitter<HomeState> emit) {
    final themeMode = _listenThemeMode.execute(_themeModeListener);
    _listenConnectionStatus.execute(_connectivityListener);

    emit(state.copyWith(themeMode: themeMode));
  }

  void _themeModeListener(ThemeMode mode) => add(_ThemeModeChanged(mode));

  void _connectivityListener({required bool connected}) => add(
        _ConnectionStatusChanged(connected: connected),
      );

  void _handleThemeModeChange(
    _ThemeModeChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(themeMode: event.mode));
  }

  Future<void> _handleConnectionStatusChange(
    _ConnectionStatusChanged event,
    Emitter<HomeState> emit,
  ) async {
    if (event.connected) {
      if (_router.current.name == NoConnectionRoute.name) {
        await _router.maybePop();
      }
      return;
    }

    await _router.push(const NoConnectionRoute());
  }
}
