import 'package:auto_route/auto_route.dart';
import 'package:character/character.dart';
import 'package:character_details/character_details.dart';
import 'package:dashboard/dashboard.dart';
import 'package:settings/settings.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  modules: <Type>[
    DashboardModule,
    CharacterModule,
    CharacterDetailsModule,
    SettingsModule,
  ],
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: DashboardRoute.page,
          initial: true,
          children: [
            AutoRoute(page: CharacterListRoute.page, initial: true),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: CharacterDetailsRoute.page),
      ];
}
