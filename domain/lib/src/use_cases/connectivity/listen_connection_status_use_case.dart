import '../../../domain.dart';
import '../../services/services.dart';

class GetConnectionStatusUseCase
    extends UseCase<Function({bool connected}), bool> {
  GetConnectionStatusUseCase(this._service);

  final ConnectivityService _service;

  @override
  bool execute(Function({required bool connected}) input) {
    _service.addListener(() => input(connected: _service.connected));

    return _service.connected;
  }
}
