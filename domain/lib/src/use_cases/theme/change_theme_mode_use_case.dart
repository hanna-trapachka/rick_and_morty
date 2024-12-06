import 'package:flutter/material.dart';

import '../../services/theme_service.dart';
import '../use_cases.dart';

class ChangeThemeModeUseCase extends FutureUseCase<ThemeMode, void> {
  ChangeThemeModeUseCase(this.themeService);

  final ThemeService themeService;

  @override
  Future<void> execute(ThemeMode input) async {
    return themeService.changeTheme(input);
  }
}
