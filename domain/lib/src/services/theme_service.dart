import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  ThemeService() {
    _init();
  }

  Future<void> _init() async {
    _storage = await SharedPreferences.getInstance();

    final savedTheme = _storage.getString(SharedPreferencesKeys.theme);
    final theme = savedTheme == null
        ? ThemeMode.system
        : _themeModeFromString(savedTheme);

    _themeMode = theme;
    notifyListeners();
  }

  late final SharedPreferences _storage;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> changeTheme(ThemeMode themeMode) async {
    try {
      await _storage.setString(SharedPreferencesKeys.theme, themeMode.name);
      _themeMode = themeMode;
      notifyListeners();
    } catch (e) {
      AppLogger().error('Could not change app theme', e);
    }
  }

  ThemeMode _themeModeFromString(String str) {
    return switch (str) {
      'system' => ThemeMode.system,
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      String() => ThemeMode.system
    };
  }
}
