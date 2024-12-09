import 'package:core/core.dart';

import '../repositories/repositories.dart';
import '../services/services.dart';
import '../use_cases/use_cases.dart';

abstract class DomainDI {
  static void initDependencies(GetIt locator) {
    _initServices(locator);
    _initUseCases(locator);
  }

  static void _initServices(GetIt locator) {
    locator.registerSingleton<ConnectivityService>(ConnectivityService());
    locator.registerSingleton<ThemeService>(ThemeService());
  }

  static void _initUseCases(GetIt locator) {
    // Connectivity
    locator.registerSingleton<GetConnectionStatusUseCase>(
      GetConnectionStatusUseCase(locator.get<ConnectivityService>()),
    );

    // Theme
    locator.registerSingleton<GetThemeModeUseCase>(
      GetThemeModeUseCase(locator.get<ThemeService>()),
    );
    locator.registerSingleton<ChangeThemeModeUseCase>(
      ChangeThemeModeUseCase(locator.get<ThemeService>()),
    );

    // Character
    locator.registerSingleton<GetCharacterListUseCase>(
      GetCharacterListUseCase(
        characterRepository: locator.get<CharacterRepository>(),
        characterRepositoryLocal: locator.get<CharacterRepositoryLocal>(),
        getConnectivityStatusUseCase: locator.get<GetConnectionStatusUseCase>(),
      ),
    );
    locator.registerSingleton<GetCharacterDetailsUseCase>(
      GetCharacterDetailsUseCase(locator.get<CharacterRepository>()),
    );
  }
}
