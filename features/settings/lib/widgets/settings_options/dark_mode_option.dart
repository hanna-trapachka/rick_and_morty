import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings_bloc.dart';

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
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Switch(
              value: state.darkMode,
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }
}
