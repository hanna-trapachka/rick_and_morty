import 'package:flutter/material.dart';

import '../../services/theme_service.dart';
import '../use_cases.dart';

class GetThemeModeStreamUseCase extends StreamUseCase<NoParams, ThemeMode> {
  GetThemeModeStreamUseCase(this.themeService);

  final ThemeService themeService;

  @override
  Stream<ThemeMode> execute([NoParams? input]) {
    return themeService.themeStream;
  }
}
