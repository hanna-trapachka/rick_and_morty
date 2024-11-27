import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class RetryErrorWidget extends StatelessWidget {
  const RetryErrorWidget({
    this.text,
    this.onTryAgainPressed,
    this.iconSize = 32,
    this.textStyle,
    super.key,
  });

  final String? text;
  final VoidCallback? onTryAgainPressed;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text ?? LocaleKeys.general_something_went_wrong.tr(),
          style: textStyle ??
              context.textTheme.labelSmall!.copyWith(
                color: context.colorScheme.onSurface,
              ),
          textAlign: TextAlign.center,
        ),
        if (onTryAgainPressed != null) ...[
          const SizedBox(height: 4),
          AppIconButton(
            onPressed: onTryAgainPressed,
            size: iconSize,
            child: const Icon(Icons.refresh),
          ),
        ],
      ],
    );
  }
}
