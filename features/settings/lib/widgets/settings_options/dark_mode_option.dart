import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DarkModeOption extends StatelessWidget {
  const DarkModeOption({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.settings_dark_mode.tr(),
          style: context.textTheme.labelMedium!.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
