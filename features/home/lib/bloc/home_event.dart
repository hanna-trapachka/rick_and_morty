part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class _HomeInit extends HomeEvent {
  const _HomeInit();
}

final class _ThemeModChanged extends HomeEvent {
  const _ThemeModChanged();
}

final class _ConnectionStatusChanged extends HomeEvent {
  const _ConnectionStatusChanged();
}
