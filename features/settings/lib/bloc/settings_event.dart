part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  factory SettingsEvent.toggleDarkMode({required bool active}) =>
      _DarkModeToggled(active: active);

  @override
  List<Object?> get props => [];
}

final class _SettingsInit extends SettingsEvent {
  const _SettingsInit();
}

final class _DarkModeToggled extends SettingsEvent {
  const _DarkModeToggled({required this.active});

  final bool active;

  @override
  List<Object?> get props => [active];
}

final class _DarkModeChangesHandled extends SettingsEvent {
  const _DarkModeChangesHandled();
}
