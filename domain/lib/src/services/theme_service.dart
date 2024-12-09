import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  ThemeService() {
    _init();
  }

  late final SharedPreferences _storage;
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> _init() async {
    _storage = await SharedPreferences.getInstance();

    final savedTheme = _storage.getString(SharedPreferencesKeys.theme);
    final theme = savedTheme == null
        ? ThemeMode.system
        : _themeModeFromString(savedTheme);

    _themeMode = theme;
    notifyListeners();
  }

  ThemeMode _themeModeFromString(String str) {
    try {
      return ThemeMode.values.byName(str);
    } catch (e) {
      AppLogger().error('Could not map enum value: $str', e);
      return ThemeMode.system;
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    try {
      await _storage.setString(SharedPreferencesKeys.theme, themeMode.name);
      _themeMode = themeMode;
      notifyListeners();
    } catch (e) {
      AppLogger().error('Could not change app theme', e);
    }
  }
}
