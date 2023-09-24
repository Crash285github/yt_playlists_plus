import 'package:yt_playlists_plus/services/abstract_saveable.dart';

abstract class SettingService<T> implements SaveableService {
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
