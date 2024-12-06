import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_settings.tr()),
      ),
      body: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.settings_dark_mode.tr(),
                  style: context.textTheme.labelMedium!
                      .copyWith(color: context.colorScheme.onSurface),
                ),
                const _ThemeSwitcher(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: appLocator.get<GetThemeModeStreamUseCase>().execute(),
      builder: (context, snapshot) {
        return Switch(
          value: snapshot.data == ThemeMode.dark,
          onChanged: (bool active) {
            appLocator
                .get<ChangeThemeModeUseCase>()
                .execute(active ? ThemeMode.dark : ThemeMode.light);
          },
        );
      },
    );
  }
}
