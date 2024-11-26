import 'package:character/character.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings/settings.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        CharacterListRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                label: LocaleKeys.dashboard_characters.tr(),
                icon: Icon(Icons.people, color: context.colorScheme.primary),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.dashboard_settings.tr(),
                icon: Icon(Icons.settings, color: context.colorScheme.primary),
              ),
            ],
          ),
        );
      },
    );
  }
}
