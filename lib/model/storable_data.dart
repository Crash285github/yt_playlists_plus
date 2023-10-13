class StorableData<T> {
  final String key;
  T value;
  void set(T value) {
    this.value = value;
  }

  StorableData({required this.key, required this.value});
}
