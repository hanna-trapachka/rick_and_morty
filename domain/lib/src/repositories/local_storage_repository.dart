abstract class LocalStorageRepository {
  Future<T?> read<T>(String key);
  Future<bool> write<T>(String key, T value);
}
