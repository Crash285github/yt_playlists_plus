///Indicates that the service's data should be saved/loaded
abstract class StorableService {
  ///The key that refers to the stored data
  late final String storableKey;

  ///Saves the data
  ///
  ///Returns the success of the save
  Future<bool> save() async {
    throw UnimplementedError('save() not implemented');
  }

  ///Loads the data
  ///
  ///Returns with the data
  Future<dynamic> load() async {
    throw UnimplementedError('load() not implemented');
  }
}
