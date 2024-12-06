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
  }

  static void _initUseCases(GetIt locator) {
    locator.registerSingleton<GetConnectivityStatusUseCase>(
      GetConnectivityStatusUseCase(locator.get<ConnectivityService>()),
    );
    locator.registerSingleton<GetCharacterListUseCase>(
      GetCharacterListUseCase(
        characterRepository: locator.get<CharacterRepository>(),
        characterRepositoryLocal: locator.get<CharacterRepositoryLocal>(),
        getConnectivityStatusUseCase:
            locator.get<GetConnectivityStatusUseCase>(),
      ),
    );
    locator.registerSingleton<GetCharacterDetailsUseCase>(
      GetCharacterDetailsUseCase(locator.get<CharacterRepository>()),
    );
  }
}
