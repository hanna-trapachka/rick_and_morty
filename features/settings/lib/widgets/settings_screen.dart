import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import '../bloc/settings_bloc.dart';
import 'settings_options/dark_mode_option.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        getDarkModeUseCase: appLocator.get<ListenThemeModeChangesUseCase>(),
        toggleDarkModeUseCase: appLocator.get<ChangeThemeModeUseCase>(),
      ),
      child: Scaffold(
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
          child: const Column(
            children: [DarkModeOption()],
          ),
        ),
      ),
    );
  }
}
