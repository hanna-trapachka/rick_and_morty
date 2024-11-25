import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

abstract class DataDI {
  static void initDependencies(GetIt locator) {
    _initApi(locator);
    _initProviders(locator);
    _initRepositories(locator);
  }

  static void _initApi(GetIt locator) {
    locator.registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: locator<AppConfig>(),
      ),
    );

    locator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(
        eventNotifier: locator<AppEventNotifier>(),
      ),
    );
  }

  static void _initProviders(GetIt locator) {
    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(locator<DioConfig>().dio),
    );

    locator.registerLazySingleton<CharacterProvider>(
      () => CharacterProvider(locator<ApiProvider>()),
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(locator<CharacterProvider>()),
    );
  }
}
