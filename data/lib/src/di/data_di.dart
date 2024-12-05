import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';
import '../providers/database/app_database.dart';

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
  }

  static void _initProviders(GetIt locator) {
    locator.registerSingleton<AppDatabase>(AppDatabase());

    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(locator<DioConfig>().dio),
    );

    locator.registerLazySingleton<CharacterProvider>(
      () => CharacterProvider(locator<ApiProvider>()),
    );

    locator.registerLazySingleton<CharacterProviderLocal>(
      () => CharacterProviderLocal(locator<AppDatabase>()),
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(
        characterProvider: locator<CharacterProvider>(),
        localProvider: locator<CharacterProviderLocal>(),
      ),
    );
  }
}
