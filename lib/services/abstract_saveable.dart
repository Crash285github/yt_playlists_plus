abstract class SaveableService {

  late String mapKey;
  
  Future<bool> save() async {
    throw UnimplementedError('save() not implemented');
  }

  Future<void> load() async {
    throw UnimplementedError('load() not implemented');
  }
}
