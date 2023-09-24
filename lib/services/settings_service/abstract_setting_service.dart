import 'package:yt_playlists_plus/services/abstract_storeable.dart';

abstract class SettingService<T> implements StoreableService {
  void set(T value) {
    throw UnimplementedError('set() not implemented');
  }

  @override
  late String mapKey;

  @override
  Future<void> load();

  @override
  Future<bool> save();
}
