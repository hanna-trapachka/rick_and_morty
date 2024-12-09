import 'package:flutter/material.dart';

import '../../services/theme_service.dart';
import '../use_cases.dart';

class GetThemeModeUseCase extends UseCase<NoParams, ThemeMode> {
  GetThemeModeUseCase(this.themeService);

  final ThemeService themeService;

  @override
  ThemeMode execute([NoParams? input]) {
    return themeService.themeMode;
  }
}
