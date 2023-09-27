import 'package:flutter/material.dart';

///Manages enabling/disabling the reordering of playlists
class ReorderService extends ChangeNotifier {
  bool canReorder = false;

  ///Enables playlist reordering
  void enable() {
    canReorder = true;
    notifyListeners();
  }

  ///Disables playlist reordering
  void disable() {
    canReorder = false;
    notifyListeners();
  }

  //__ Singleton
  static final ReorderService _instance = ReorderService._();
  factory ReorderService() => _instance;
  ReorderService._();
}
