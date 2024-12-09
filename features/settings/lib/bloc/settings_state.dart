part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({this.darkMode = false});

  final bool darkMode;

  SettingsState copyWith({bool? darkMode}) =>
      SettingsState(darkMode: darkMode ?? this.darkMode);

  @override
  List<Object?> get props => [darkMode];
}
