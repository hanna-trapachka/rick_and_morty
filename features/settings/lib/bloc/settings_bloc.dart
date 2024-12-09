import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.service,
    required GetThemeModeUseCase getDarkModeUseCase,
    required ChangeThemeModeUseCase toggleDarkModeUseCase,
  })  : _getDarkMode = getDarkModeUseCase,
        _changeThemeModeUseCase = toggleDarkModeUseCase,
        super(const SettingsState()) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        final _SettingsInit e => _init(e, emit),
        final _DarkModeToggled e => _toggleDarkMode(e, emit),
        final _DarkModeChangesHandled e => _handleDarkModeChange(e, emit),
      },
    );

    service.addListener(() => add(const _DarkModeChangesHandled()));

    add(const _SettingsInit());
  }
  final ThemeService service;
  final GetThemeModeUseCase _getDarkMode;
  final ChangeThemeModeUseCase _changeThemeModeUseCase;

  void _init(_SettingsInit event, Emitter<SettingsState> emit) {
    final mode = _getDarkMode.execute();

    emit(state.copyWith(darkMode: _isDarkMode(mode)));
  }

  void _themeModeListener() => add(const _DarkModeChangesHandled());

  bool _isDarkMode(ThemeMode mode) => mode == ThemeMode.dark;

  Future<void> _toggleDarkMode(
    _DarkModeToggled event,
    Emitter<SettingsState> emit,
  ) async {
    await _changeThemeModeUseCase
        .execute(event.active ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _handleDarkModeChange(
    _DarkModeChangesHandled event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(darkMode: _isDarkMode(_getDarkMode.execute())));
  }

  @override
  Future<void> close() {
    service.removeListener(_themeModeListener);
    return super.close();
  }
}
