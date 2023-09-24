///Indicates that the service's data should be saved/loaded
abstract class StoreableService {
  ///The key that refers to the stored data
  late final String mapKey;

  ///Saves the data
  Future<bool> save() async {
    throw UnimplementedError('save() not implemented');
  }

  ///Loads the data
  Future<void> load() async {
    throw UnimplementedError('load() not implemented');
  }
}
