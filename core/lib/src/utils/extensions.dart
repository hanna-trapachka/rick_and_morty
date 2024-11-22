import 'package:flutter/material.dart';

import '../../core.dart';

extension LocaleObserver on String {
  String watchTr(
    BuildContext context, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    // TODO(ann): is this required?
    context.locale;
    return this.tr(args: args, namedArgs: namedArgs, gender: gender);
  }
}
