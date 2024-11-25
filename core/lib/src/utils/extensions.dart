import 'package:flutter/material.dart';

import '../../core.dart';

extension LocaleObserver on String {
  String watchTr(
    BuildContext context, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    context.locale;
    return this.tr(args: args, namedArgs: namedArgs, gender: gender);
  }
}

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Brightness get brightness => theme.brightness;
}
