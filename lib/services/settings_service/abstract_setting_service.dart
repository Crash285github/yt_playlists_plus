interface class SettingService<T> {
  void set(T value) {
    throw UnimplementedError('set() not implemented');
  }

  late String dataKey;
  Future<bool> save() async {
    throw UnimplementedError('save() not implemented');
  }

  Future<void> load() async {
    throw UnimplementedError('load() not implemented');
  }
}
