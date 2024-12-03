import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core.dart';

class OfflineModeService {
  OfflineModeService() {
    _controller = StreamController<bool>.broadcast();
    stream.listen((bool activated) {
      _offlineModeActive = activated;
    });

    appLocator.getAsync<SharedPreferences>().then((storage) {
      _storage = storage;
      _offlineModeActive = _storage.getBool('offline') ?? false;
      _controller.add(_offlineModeActive);
    });
  }

  late final StreamController<bool> _controller;
  late final SharedPreferences _storage;

  Future<void> notify({required bool active}) async {
    _controller.add(active);
    await _saveLocally(active);
  }

  Stream<bool> get stream => _controller.stream;

  late bool _offlineModeActive;

  bool get offlineModeActive => _offlineModeActive;

  Future<void> _saveLocally(bool active) async {
    await _storage.setBool('offline', active);
  }
}
