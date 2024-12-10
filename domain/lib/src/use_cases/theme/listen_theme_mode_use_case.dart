import 'package:flutter/material.dart';

import '../../services/theme_service.dart';
import '../use_cases.dart';

class ListenThemeModeUseCase extends UseCase<Function(ThemeMode), ThemeMode> {
  ListenThemeModeUseCase(this.themeService);

  final ThemeService themeService;

  @override
  ThemeMode execute(Function(ThemeMode) input) {
    themeService.addListener(() => input(themeService.themeMode));

    return themeService.themeMode;
  }
}
