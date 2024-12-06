import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  ThemeService() {
    _init();
  }

  Future<void> _init() async {
    _storage = await SharedPreferences.getInstance();

    final savedTheme = _storage.getString(SharedPreferencesKeys.theme);
    final theme = savedTheme == null
        ? ThemeMode.system
        : _themeModeFromString(savedTheme);

    _controller = StreamController<ThemeMode>.broadcast(
      onListen: () => _controller.add(theme),
    );
  }

  late final SharedPreferences _storage;
  late final StreamController<ThemeMode> _controller;

  Stream<ThemeMode> get themeStream => _controller.stream;

  Future<void> changeTheme(ThemeMode themeMode) async {
    try {
      await _storage.setString(SharedPreferencesKeys.theme, themeMode.name);
      _controller.add(themeMode);
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
