import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, Brightness> {
  ThemeBloc() : super(Brightness.light) {
    on<ThemeEvent>(
      (event, emit) => switch (event) {
        final _InitialThemeSet e => _setInitialTheme(e, emit),
        final _ThemeChanged e => _setTheme(e, emit)
      },
    );

    add(ThemeEvent.initial());
  }

  Future<void> _setInitialTheme(
    _InitialThemeSet event,
    Emitter<Brightness> emit,
  ) async {
    final brightness = await _getTheme();
    emit(brightness);
  }

  Future<void> _setTheme(_ThemeChanged event, Emitter<Brightness> emit) async {
    final theme = await _getTheme();
    final newTheme =
        theme == Brightness.light ? Brightness.dark : Brightness.light;

    emit(newTheme);
    await setTheme(newTheme);
  }
}

Future<Brightness> _getTheme() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final savedTheme = sharedPreferences.getString('theme');

  if (savedTheme == null) {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  return savedTheme == 'dark' ? Brightness.dark : Brightness.light;
}

Future<void> setTheme(Brightness theme) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  await sharedPreferences.setString('theme', theme.name);
}

sealed class ThemeEvent {
  const ThemeEvent();

  factory ThemeEvent.initial() => _InitialThemeSet();
  factory ThemeEvent.change() => _ThemeChanged();
}

class _InitialThemeSet extends ThemeEvent {}

class _ThemeChanged extends ThemeEvent {}
