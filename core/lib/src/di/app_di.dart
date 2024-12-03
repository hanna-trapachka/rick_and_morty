import 'package:shared_preferences/shared_preferences.dart';

import '../../core.dart';

final GetIt appLocator = GetIt.instance;

const String unauthScope = 'unauthScope';
const String authScope = 'authScope';

abstract class AppDI {
  static void initDependencies(GetIt locator, Flavor flavor) {
    locator.registerSingleton<AppConfig>(
      AppConfig.fromFlavor(flavor),
    );

    locator.registerLazySingleton<AppEventBus>(
      AppEventBus.new,
    );

    locator.registerLazySingleton<AppEventNotifier>(
      appLocator.call<AppEventBus>,
    );

    locator.registerLazySingleton<AppEventObserver>(
      appLocator.call<AppEventBus>,
    );

    locator.registerLazySingletonAsync(
      () async => SharedPreferences.getInstance(),
    );

    locator.registerSingleton(OfflineModeService());
  }
}
