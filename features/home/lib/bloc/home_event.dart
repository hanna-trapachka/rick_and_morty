part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class _HomeInit extends HomeEvent {
  const _HomeInit();
}

final class _ThemeModeChanged extends HomeEvent {
  const _ThemeModeChanged(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}

final class _ConnectionStatusChanged extends HomeEvent {
  const _ConnectionStatusChanged();
}
