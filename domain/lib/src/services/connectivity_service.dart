import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService with ChangeNotifier {
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        final isConnected = !result.contains(ConnectivityResult.none);
        _updateConnection(isConnected);
      },
    );
  }

  bool _connected = true;

  bool get connected => _connected;

  void _updateConnection(bool connected) {
    _connected = connected;
    notifyListeners();
  }
}
