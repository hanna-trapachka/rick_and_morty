import 'dart:async';

import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  LocalStorageRepositoryImpl();

  SharedPreferences? _instance;

  Future<SharedPreferences?> getInstance() async {
    return _instance ??= await SharedPreferences.getInstance();
  }

  @override
  Future<T?> read<T>(String key) async {
    final instance = await getInstance();
    return instance?.get(key) as T?;
  }

  @override
  Future<bool> write<T>(String key, T value) async {
    final instance = await getInstance();

    if (instance == null) return false;

    switch (T) {
      case const (String):
        return instance.setString(key, value as String);
      case const (bool):
        return instance.setBool(key, value as bool);
      case const (double):
        return instance.setDouble(key, value as double);
      case const (int):
        return instance.setInt(key, value as int);
      case const (List<String>):
        return instance.setStringList(key, value as List<String>);
      default:
        throw Exception('Trying to set unsupported value type');
    }
  }
}
