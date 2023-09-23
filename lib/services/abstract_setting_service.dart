abstract class SettingService<T> {
  void set(T value);

  late String dataKey;
  Future<bool> save();
  Future<void> load();
}
