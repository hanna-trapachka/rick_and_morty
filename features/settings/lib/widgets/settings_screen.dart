import 'package:core/core.dart';
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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.settings_offline_mode.tr(),
                  style: context.textTheme.labelMedium!
                      .copyWith(color: context.colorScheme.onSurface),
                ),
                const _OfflineModeSwitcher(),
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
    return BlocBuilder<ThemeBloc, Brightness>(
      builder: (context, state) => Switch(
        value: state == Brightness.dark,
        onChanged: (bool val) {
          context.read<ThemeBloc>().add(ThemeEvent.change());
        },
      ),
    );
  }
}

class _OfflineModeSwitcher extends StatelessWidget {
  const _OfflineModeSwitcher();

  @override
  Widget build(BuildContext context) {
    final service = appLocator.get<OfflineModeService>();

    return StreamBuilder<bool>(
      stream: service.stream,
      builder: (context, snapshot) {
        return Switch(
          value: service.offlineModeActive,
          onChanged: (bool val) async {
            await service.notify(active: val);
          },
        );
      },
    );
  }
}
