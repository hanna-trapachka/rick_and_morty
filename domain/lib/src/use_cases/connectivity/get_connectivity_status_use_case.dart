import '../../../domain.dart';

class GetConnectivityStatusUseCase extends UseCase<NoParams, bool> {
  GetConnectivityStatusUseCase(this._connectivityService);

  final ConnectivityService _connectivityService;

  @override
  bool execute([NoParams? input]) {
    return _connectivityService.connected;
  }
}
