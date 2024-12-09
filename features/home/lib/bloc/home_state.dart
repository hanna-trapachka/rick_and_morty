part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;

  HomeState copyWith({ThemeMode? themeMode}) =>
      HomeState(themeMode: themeMode ?? this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}
