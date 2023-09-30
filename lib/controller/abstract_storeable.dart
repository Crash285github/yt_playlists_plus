///Indicates that the controller's data should be saved/loaded
abstract class StorableController {
  ///The key that refers to the stored data
  late final String storageKey;

  ///Saves the data
  ///
  ///Returns the success of the save
  Future<bool> save();

  ///Loads the data
  ///
  ///Returns with the data
  Future<dynamic> load();
}
