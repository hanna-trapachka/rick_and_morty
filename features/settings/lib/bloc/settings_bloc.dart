import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required ListenThemeModeChangesUseCase getDarkModeUseCase,
    required ChangeThemeModeUseCase toggleDarkModeUseCase,
  })  : _getDarkMode = getDarkModeUseCase,
        _changeThemeModeUseCase = toggleDarkModeUseCase,
        super(const SettingsState()) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        final _SettingsInit e => _init(e, emit),
        final _DarkModeToggled e => _toggleDarkMode(e, emit),
        final _ThemeModeChanged e => _handleDarkModeChange(e, emit),
      },
    );

    add(const _SettingsInit());
  }

  final ListenThemeModeChangesUseCase _getDarkMode;
  final ChangeThemeModeUseCase _changeThemeModeUseCase;

  void _init(_SettingsInit event, Emitter<SettingsState> emit) {
    final mode = _getDarkMode.execute(_themeModeListener);

    emit(state.copyWith(darkMode: _isDarkMode(mode)));
  }

  void _themeModeListener(ThemeMode mode) => add(_ThemeModeChanged(mode));

  bool _isDarkMode(ThemeMode mode) => mode == ThemeMode.dark;

  Future<void> _toggleDarkMode(
    _DarkModeToggled event,
    Emitter<SettingsState> emit,
  ) async {
    await _changeThemeModeUseCase
        .execute(event.active ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _handleDarkModeChange(
    _ThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(darkMode: _isDarkMode(event.mode)));
  }
}
