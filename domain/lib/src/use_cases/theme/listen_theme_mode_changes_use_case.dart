import 'package:flutter/material.dart';

import '../../services/theme_service.dart';
import '../use_cases.dart';

class ListenThemeModeChangesUseCase
    extends UseCase<Function(ThemeMode), ThemeMode> {
  ListenThemeModeChangesUseCase(this.themeService);

  final ThemeService themeService;

  @override
  ThemeMode execute(Function(ThemeMode) input) {
    themeService.addListener(() => input(themeService.themeMode));

    return themeService.themeMode;
  }
}
