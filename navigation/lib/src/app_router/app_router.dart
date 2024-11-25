import 'package:auto_route/auto_route.dart';

import 'package:character/character.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  modules: <Type>[
    CharacterModule,
  ],
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: CharacterListRoute.page, initial: true),
        AutoRoute(page: CharacterDetailsRoute.page),
      ];
}
