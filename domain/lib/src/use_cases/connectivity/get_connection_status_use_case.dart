import '../../../domain.dart';

class GetConnectionStatusUseCase extends UseCase<NoParams, bool> {
  GetConnectionStatusUseCase(this._connectivityService);

  final ConnectivityService _connectivityService;

  @override
  bool execute([NoParams? input]) {
    return _connectivityService.connected;
  }
}
