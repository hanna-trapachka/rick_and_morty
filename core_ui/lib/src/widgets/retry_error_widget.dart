import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    this.text,
    this.iconSize = 32,
    this.textStyle,
    super.key,
  });

  final String? text;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error_outline, size: iconSize),
        const SizedBox(width: 8),
        Text(
          text ?? LocaleKeys.general_something_went_wrong.tr(),
          style: textStyle ??
              context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.onSurface,
              ),
        ),
      ],
    );
  }
}
